--���弼��ID
  ������  =3962  ������ =3959  ������ħ�� =3967   ������Ӱ = 3977  ڤ�¶���=18629 ����ն =3963  ����ն = 3960   ��������=18626   ������ =3966 �������� = 4910  ��ҹ�ϳ� =3979   ������� = 3978  ������ɢ =3974   ������ =3969  ��Į����=4326  �ùⲽ =3970  ̰ħ�� = 3973  ��η����=3975  �ùⲽ2=18633 
  ��ʨ�Ӻ�=252  Ħڭ����=236 ������� =366
--����BUFF
  ����F =4052  ����2F =5496  ��ľ����F = 9908 ��ľ����F = 9906  ����F =4052  ����F=4056  ������F = 4423  �½�F =4030  �ս�F =4029  ��������F = 4871   ̰ħ��F =4439  ڤ�¶���F =12491  �Ϸ�����F= 9934  ��ɽ��F=377
--���弼��UIID
  ������U =3868  ������U =3808    ����նU =3796   ����U=3799   ����U=3785    ����U =3795  �ùⲽU = 4173   ��̫��2F=11991  ����F=12665  ̰ħ��U =4178
  ��ɽ��F=377  ��������F = 11151  Ӱ��F=9694  Ӱ��F2=9693
--����ְҵ��������
  �Ƴ��F = 2840 BF�Ƴ��F2 = 2830    ��Ȫ����F =1802
--������Ѩ
  ������� =18635 �ƶ����� =6727  ��Ȼ���� =5984  ��Ӱ=6893  ֪������ =4173  ������ʥ=6720
--��ر�����ļ���
  ������Ӱ=3112  ڤ�¶���=18629   �������� =2681 �������� =568  ������=260   �������=2645

  nReset_CRL=0
  nReset_YYL=0

  �ű�˵��("�����ռ�4/24���Ż����������6�뱬�����ˡ�֧��ȫ��Ѩ")

--�������  
  ��ȻF =4468 ��� =4421   

�Ƿ��ҡ =0
��ҡ��ʧ =0

ID�������� = ��������("��������",2222)
ID��ս���� = ��������("��ս����",2222)
ID�Զ����� = ��������("�Զ�����",2222)
ID�Զ���ҹ = ��������("�Զ���ҹ",2222)
ID�Զ���� = ��������("�Զ����",2222)
ID����ģʽ = ��������("����ģʽ",2222)
ID�����١�ѣ�� = ��������("�����١�ѣ��",2222)

���ýű���("����PVP")

̰ī�屣�� = 0

	if ���� ==0 and m����==m���� then
        �ֶ�����("����ն",����ն)
	�ֶ�����("̰ħ��",̰ħ��)
	�ֶ�����("�������",�������)
	�ֶ�����("������ɢ",������ɢ)
	�ֶ�����("�ùⲽ",�ùⲽ)
	�ֶ�����("������ħ��",������ħ��)
	�ֶ�����("������",������)
	�ֶ�����("ڤ�¶���",ڤ�¶���)
	�ֶ�����("��������",��������)
	�ֶ�����("��ҹ�ϳ�",��ҹ�ϳ�)
	�ֶ�����("��������",��������)
	�ֶ�����("������Ӱ",������Ӱ)
	����=1
	end 

	
function ����PVP ()


	if ���� ==0 and m����==m���� then
        �ֶ�����("����ն",����ն)
	�ֶ�����("̰ħ��",̰ħ��)
	�ֶ�����("�������",�������)
	�ֶ�����("������ɢ",������ɢ)
	�ֶ�����("�ùⲽ",�ùⲽ)
	�ֶ�����("������ħ��",������ħ��)
	�ֶ�����("������",������)
	�ֶ�����("ڤ�¶���",ڤ�¶���)
	�ֶ�����("��������",��������)
	�ֶ�����("��ҹ�ϳ�",��ҹ�ϳ�)
	�ֶ�����("��������",��������)
	�ֶ�����("������Ӱ",������Ӱ)
	�ֶ�����("������",������)
	�ֶ�����("������",������)
	�ֶ�����("��η����",��η����)
	����=1
	end 
			   
��ȡ���Ŀ��״̬()

local t���� =bufftimeT(����)
local t�ս� =bufftimeT(�ս�F)
local f����=bufftimeR(����F)
local f����2=bufftimeR(����2F)
local fڤ�¶���=bufftimeR(ڤ�¶���F)
local f��ӯ = bufftimeR(12487)
local f���� = bufftimeR(����F)
local ft��������=bufftimeT(��������F)
local ft��Ȫ����=bufftimeT(��Ȫ����F)
local cn̰ħ��=UICALL(̰ħ��U,UI_CHONGNENG)
local f���� = bufftimeR(����F)
local m̰ħ��F = bufftimeR(̰ħ��F)
local af����= SkillAfter(������Ӱ)
local cd����ն=����CD(����ն)
local m���� = bufftimeR(1911,1912,1913,1914,1915,1916,1917,1918,1919,1920,1921,1922,3028,3487,3488,4930,4931,6466,6471,8474,10192,11376,12768)
local ft�������= bufftimeR(Ӱ��F,Ӱ��F2)
local ft����=GetBuffS("����",����F)
local N�Ե����_60�� = ��Χ�ж����(60)
local �������� = ���������Ƿ���(ID��������)
local ��ս���� = ���������Ƿ���(ID��ս����)
local �Զ����� = ���������Ƿ���(ID�Զ�����)
local �Զ���ҹ = ���������Ƿ���(ID�Զ���ҹ)
local �Զ���� = ���������Ƿ���(ID�Զ����)
local ����ģʽ = ���������Ƿ���(ID����ģʽ)
local �����١�ѣ�� = ���������Ƿ���(ID�����١�ѣ��)	
local t����=menpai(target)
local �������=���ܵȼ�(�������)
local GCD=����GCD(������)
local ������CD=����CD(������)
local bufftime�������� =bufftimeT(��������F)
local fm������� = bufftimeR(��Ȼ����,�Ƴ��F,�Ƴ��F2,����F)
local f�½� = bufftimeT(�½�F)
local nState = Ŀ��״̬()
local t��ɽ�� = bufftimeT(��ɽ��F)
local t�Ϸ����� = bufftimeT(�Ϸ�����F)
local t���� = bufftimeT(11361,11385,10258,11077,11148,11149,16381,8247,8864,1186,4439,5994,5995,5996,8458,1802,3973)

--���ܼ���ж�

local nC������� , nC�������ID = �жԶ��Լ��ͷŵļ���(�������,2000,20)
local nC������Ӱ , nC������ӰID = �жԶ��Լ��ͷŵļ���(������Ӱ,1500,30)
local nC׽Ӱʽ , nC׽ӰʽID = �жԶ��Լ��ͷŵļ���(׽Ӱʽ,500,25)
local nCǧ��׹ , nCǧ��׹ID = �жԶ��Լ��ͷŵļ���(ǧ��׹,400,20)
local nC������Ӱ , nC������ӰID = �жԶ��Լ��ͷŵļ���(������Ӱ,400,30)
local nC���� , nC����ID =   �жԶ��Լ��ͷŵļ���(����,400,12)
local nC���� , nC����ID = �жԶ��Լ��ͷŵļ���(����,400,20)
local nC�ϻ�� , nC�ϻ��ID = �жԶ��Լ��ͷŵļ���(�ϻ��,400,27)
local nC������ , nC������ID = �жԶ��Լ��ͷŵļ���(������,10000,10)
local nC��Ծ��Ԩ , nC��Ծ��ԨID = �жԶ��Լ��ͷŵļ���(��Ծ��Ԩ,7000,20)
local nC��ս��Ұ , nC��ս��ҰID = �жԶ��Լ��ͷŵļ���(��ս��Ұ,7000,20)
local nC�������� , nC��������ID = �жԶ��Լ��ͷŵļ���(��������,7000,20)
local nC�������� , nC��������ID = �жԶ��Լ��ͷŵļ���(��������,3000,20)
local Ԥ��_���� = Ԥ�ежԼ���(����,15000,8,��ˮ,"����",15)
local Ԥ��_�Ƽ���,Ԥ��_�Ƽ���ID = Ԥ�ежԼ���(�Ƽ���,15000,4,��Ѫ,"ս��",3)
local Ԥ��_��Ӱ����,Ԥ��_��Ӱ����ID = Ԥ�ежԼ���(��Ӱ����,8000,10,����,0,0)
local Ԥ��_�������,Ԥ��_�������ID = Ԥ�ежԼ���(�������,8000,20,����,"����",4)

        if ��ս���� == 1 and ��ս˲��() == 1 then
		if  f���� <0 and fڤ�¶��� <0 then
		�ͷ�(������ɢ)
		end
        end

        ��������()   
        �Ƿ�ж�()

        if �Զ���ҹ == 0 and ���ܴ���(������ɢ,4000) == 1 then 
                return 0
	end

        if SkillAfter(��������)>0 and SkillAfter(��������)<1300 then 
                return 0
	end
        

        --�˵�����

        if ISNPC() == 4 and ���ܵȼ�(14698) == 1 and t����� <0 then
        if SkillAfter(�������) > 1500 then
		�ͷ�(��η����) 
        end
        if SkillAfter(��η����) < 1300 then
		�ͷ�(������,1)
	end        
        if SkillAfter(������) < 1300 then
                �ͷ�(����ն)
	end
        if SkillAfter(����ն) < 1500 then
		�ͷ�(��ҹ�ϳ�)
	end 
        if SkillAfter(��ҹ�ϳ�) < 1500 then
		�ͷ�(��������)
	end 
        if SkillAfter(��������) < 3000 and SkillAfter(������) < 9000 then
		�ͷ�(������ħ��)
	end
        if bufftimeT(6365) >0 and SkillAfter(�������) > 7000 and SkillAfter(������ɢ) > 2000 and SkillAfter(������) < 9000 then
                �ͷ�(������ɢ)
        end
        if SkillAfter(������ɢ) < 999 and SkillAfter(������ħ��) < 3000 then
		�ͷ�(�������)
	end
        if SkillAfter(�������) < 1500 then
		�ͷ�(��η����)
	end
        if SkillAfter(��η����) < 1300 and SkillAfter(������) > 1500 then
		�ͷ�(��ҹ�ϳ�)
	end
        if SkillAfter(�������) > 888 and SkillAfter(�������) < 9000 then
		�ͷ�(������ħ��) 
		�ͷ�(��ҹ�ϳ�)
		�ͷ�(����ն)
                �ͷ�(����ն)
	end
        if ��ս˲��() == 1 then
	if f���� <0 and fڤ�¶��� <0 then
		�ͷ�(������ɢ)
	end
        end
                return 0
	end 

  
        if t���� < 0 and �Զ���ҹ ==1 and bufftimeT(��������F) <0 then
	if fڤ�¶���<0 then
		�ͷ�(��ҹ�ϳ�)
		end
	end

	if f���� < 4000 then 
        if m���� > 2000  and GCD ==1   and t����~=m�嶾  and t����~=m���� and t���� ~=m����   and ���.nState ~= �Ṧ  and m̰ħ��F < 0  then
		�ı�����(128)
			if bufftimeR(��ҡF)>0 then
			  ��(1,1)
			end
		�ͷ�(��������)
		�ͷ�(������ʤ)
        end 

        if m��Ĭ > 2000  and GCD ==1   and t����~=m�嶾  and t����~=m���� and t���� ~=m����   and ���.nState ~= �Ṧ   and m̰ħ��F < 0  then
		�ı�����(128)
			if bufftimeR(��ҡF)>0 then
			  ��(1,1)
			end
		�ͷ�(��������)
		�ͷ�(������ʤ)
        end 

        if t���� > 0 or t��ɽ�� > 0 or t�Ϸ����� > 0 or m̰ħ��F > 0 then
		return 0
	end   
  
        if ��ֹ����() == 1 and GCD==1  and ���.nState ~= �Ṧ  then

        end 

        if m̰ħ��F < 0 then 
	        �رܷ糵�����()
        end

        if Ŀ��.nState == ���� then 
                return 0  
        end

        if nC������� == me then
		�ͷ�(̰ħ��)
	end

        if fڤ�¶��� >0 and m̰ħ��F <0 and Distance <12 and �糵==0 then
		���Ŀ��()
        end 

        if af���� <1000 and GCD==1 and m̰ħ��F <0 and bufftimeT(��������F) <0 and �糵==0 and Distance < 6 then
	        ���Ŀ��()
        end 

        ����ǰ��(������,1000)
	����ǰ��(��������,1000)
	����ǰ��(������ħ��,1000)
	
	if m̰ħ��F <0 then
		����ǰ��(̰ħ��,1000)	
	end 
	
	if t���� == �Ե� and Distance < 60 then
		�ͷ�(��ҡ)
	end 

	if bufftimeT(��������F) >0 then
        if bufftimeT(��������F) <3333 then
                �ͷ�(��ҹ�ϳ�)
        end
	if bufftimeT(��������F) <2000 then
	if ���.����==1 then
                �ͷ�(��Į����)
	        �ͷ�(������ħ��)
	end			
	if ���.����==1 then
		�ͷ�(��Į����)
		�ͷ�(������)
	end
        if ���.���� >= 6000 then
		�ͷ�(����ն)
        end
        if ���.���� >= 6000 then
		�ͷ�(����ն)
        end
	end
        return 0
	end

	if ISNPC() == 3 then
		����(������ħ��)
	end 

        --���ܼ��

        if fm������� <0 and fڤ�¶��� <0 and SkillAfter(������Ӱ) > 3000 and SkillAfter(������ɢ)> 2000 and SkillAfter(�ùⲽ)>3000 and m����<0 then
        if CheckSkill(1577,0,1000) == me or CheckSkill(1596,0,900) == me or CheckSkill(13424,0,900) == me or CheckSkill(5259,0,900) == me or CheckSkill(18604,0,900) == me or CheckSkill(18633,0,900) == me or CheckSkill(16455,0,1300) == me or CheckSkill(16621,0,1300) == me or CheckSkill(242,0,1500) == me then
                        �ͷ�(������ʤ)
		        �ͷ�(ӭ�����)
		        �ͷ�(��̨���) 
	end
        end       
       
        if fm������� <0 and fڤ�¶��� <0 and SkillAfter(������ɢ)> 2000 and SkillAfter(�ùⲽ)>3000 and m����<0 then
        if CheckSkill(5269,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(1613,0,2500) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(2690,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(5262,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(303,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(5266,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(428,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(3977,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(15187,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(16479,0,900) == me then
                        �ͷ�(������Ӱ)
	end
        if CheckSkill(13046,0,900) == me then 
                        �ͷ�(������Ӱ)                  
        end      
        if CheckSkill(13054,0,900) == me then
                        �ͷ�(������Ӱ) 
	end
        if CheckSkill(16621,0,900) == me then
                        �ͷ�(������Ӱ) 
	end
        if CheckSkill(228,0,900) == me then
                        �ͷ�(������Ӱ) 
	end
        end 

        if fm������� <0 and fڤ�¶��� <0 and SkillAfter(������Ӱ) > 3000 and SkillAfter(������ɢ)> 3000 and SkillAfter(�ùⲽ)>3000 and m����<0 then
        if Ԥ��_���� == me or Ԥ��_Ħڭ���� == me or Ԥ��_������� == me then
		�ͷ�(������ʤ)
		�ͷ�(ӭ�����)
		�ͷ�(��̨���)
                �ͷ�(������Ӱ)
	end 
	if Ԥ��_�Ƽ��� == me  and t����>0 and Ŀ��ID() == Ԥ��_�Ƽ���ID then
		�ͷ�(������ʤ)
		�ͷ�(ӭ�����)
		�ͷ�(��̨���)
		�ͷ�(������Ӱ)
	end
        end

        if m̰ħ��F <0 and m����<0 and m����<0 and fڤ�¶��� < 0 and SkillAfter(������ɢ)>2000 and  SkillAfter(ڤ�¶���)>2000 then
		if nC������Ӱ == me or nC������� == me then
		  �ͷ�(̰ħ��)
		end 
		if  ���.nHP <70 then
		if nC�������� == me then  
			if Ԥ��_��Ӱ���� == me then
				 �ͷ�(̰ħ��)
			end 
		end 
			if nC�������� == me then   
				if Ԥ��_������� == me  and ft���� >=1 then
					 �ͷ�(̰ħ��)
				end 
			end
		end
		if  ������ == 1 then	
			if nC�������� == me and Ŀ��.nHP > 30 then
				�ͷ�(̰ħ��)
			end
		end		
		if  ������ >=2 then
			if nC�������� == me and Ŀ��.nHP > 30 and ���.nHP <80 then
				�ͷ�(̰ħ��)
			end
		end 
		if �����ķ糵() == 1 then
		  if bufftimeR(��ҡF)> 0 then
			��(1,1)
		  end 
		
		end 
	end

        if CheckSkill(3110,0,700) == me and m̰ħ��F < 0  and m����<0 and m����<0 and fڤ�¶��� < 0 and SkillAfter(������ɢ)>2000 and SkillAfter(ڤ�¶���)>2000 then
                        �ı�����(128)
                        �ͷ�(��������)
	end

        if m̰ħ��F < 0 and m����<0 and m����<0 and fڤ�¶��� <0 and SkillAfter(������ɢ) >2000 and SkillAfter(ڤ�¶���)>2000 and ���.nHP <77 then
        if CheckSkill(260,0,900) == me or CheckSkill(1596,0,900) == me or CheckSkill(2681,0,900) == me or CheckSkill(3112,0,900) == me or CheckSkill(3094,0,900) == me or CheckSkill(3969,0,900) == me or CheckSkill(313,0,900) == me or CheckSkill(15193,0,900) == me or CheckSkill(3110,0,900) == me or        
        CheckSkill(3978,0,700) == me or CheckSkill(18629,0,700) == me then
	                �ͷ�(̰ħ��)
	end
        end

        if Ŀ��.nHP > 30 and Distance > 15 and ���.nState ~= ���� and ���.nState ~= �Ṧ then
		        �ͷ�(��ҡ,1)
	end

	--����	

        if SkillAfter(������ɢ)> 2000 and fڤ�¶��� < 0 and m̰ħ��F <0 and SkillAfter(ڤ�¶���)>2000 then
	if t�糵 == 1 and Distance < 10 then
	if cn̰ħ�� == 2 then
		�ͷ�(̰ħ��)
	end 
        end
        if t�糵 == 1 and Distance <10 and m̰ħ��F < 0 and ����CD(��������)==0 and bufftimeR(��ҡF)<0 and ���.nState ~=���� then
	if cn̰ħ�� == 1 then
		�ͷ�(̰ħ��)
	end 
        end 	
	if ���.nHP < 35 and Ŀ��.nHP > ���.nHP and m���� <0 and ������>=1 and t���� ==0 then
		�ͷ�(̰ħ��)
	end 
	end

        --�Զ����  

	if �Զ���� == 1 and SkillAfter(������Ӱ) >3000 and fڤ�¶��� <0 and SkillAfter(ڤ�¶���) >9000 and m̰ħ��F < 0 then
	if ���ܵȼ�(18634) ==1 and m���� ==1 then
		�ͷ�(�ùⲽ2,4,20,1)
	end
        if SkillAfter(�ùⲽ2)> 3000 and ���.nState == E then
		�ͷ�(������Ӱ)
	end 
	end 

	if ���.nState == ���� then
		�ͷ�(��������)
	end 

        --����

        if �Զ����� == 1 then
        if ���.���� == 1 and ���ɿ��Ƽ���BUFF<0 then
	if t��Ĭ <1000 and SkillAfter(��η����)>1000 then
	if ���.���� <3000 and t���� < 0 and  t���� < 0 and fڤ�¶��� <0 and m���� <0 then
		����(������,1,15)
	end
        end
        end

        if bufftimeT(��������F) < 4000  and t����==0  then
        if ���.���� == 1 and ���ɿ��Ƽ���BUFF <0 and t�糵==0 then  
	if t���<0 and Distance > 8  and  ���.���� < 3000 and  m���� <0 and t����==0 then
		�ͷ�(������,1,17)
	end 
        end
        end
        end
	
        --����

	if t����<0 and t���� <0 then
		����(��������,0,8)
	end 
	if t����<0 and f���� < 0 then
		����(ڤ�¶���,0,12)  
	end
	if t����<0 and t���� ==m����  then
		����(��������,0,8)
	end 
	if t����<0 and t���� ==m���� and f���� < 0 then
		����(ڤ�¶���,0,12)  
	end 
	if t����<0 and t���� ==m���� and f���� < 0 then
		����(ڤ�¶���,0,12)  
	end

        --����
        
        if ����ģʽ == 1 and m̰ħ��F <0 and GCD == 1 and ���.���� == 1 and t���� <2000 then
	    �ͷ�(������,2,6,1)	
        end
        if ����ģʽ == 1 and m̰ħ��F <0 and GCD == 1 and ���ܵȼ�(6727) == 1 and t���� <2000 then
	    �ͷ�(������,2,6,1)	
        end


        --�´����
 	
	if fڤ�¶��� > 0 then  
                �ͷ�(��ҹ�ϳ�)
        if �����١�ѣ�� == 1 and ���.���� == 1 and GCD==1 and m̰ħ��F <0 and m���� <0 and t���� <0 and SkillAfter(������) > 8000 then
	        ����(������,ѣ��,10,2,6,1)	
        end
        if t����<0 and m���� >0 then
		�ͷ� (������ħ��)
	end
        if ���.���� == 1 or ���.���� == 1 then
		�ͷ�(������ħ��)
        end
        if SkillAfter(������) <7000 and SkillAfter(������) > 10 then
	        �ͷ�(������ħ��)
	end
		if ���.���� >=  ���.���� then
			�ͷ�(����ն)
			if ����CD(����ն)==0 and ����CD(��ҹ)==0 then
				�ͷ�(������)
			end
			else
                        if bufftimeT(�ս�F) <0 then
			�ͷ�(����ն)
                        end
			if ����CD(����ն)==0 and ����CD(��ҹ)==0 then
				�ͷ�(������)
			end
		end
             return 0
	end

        --����

        if ISNPC() == 4 and Distance >8 and ���ܵȼ�(֪������) == 1 and Distance <20 and ���.���� == 0 and ���.���� == 0 then
	    ����(�ùⲽ,ѣ��,900,4,20,1)
	end
        if ISNPC() == 4 and �����١�ѣ�� == 1 and ���.���� == 1 and m̰ħ��F <0 and m���� <0 and fڤ�¶��� <0 and f���� <0 and bufftimeR(������F) <0 and GetBuffS("Ŀ��",�ս�F) >=1 and bufftimeT(�ս�F) <700 and Distance <15 then
	    return 0	
        end
        if GCD==1 and ���.���� == 1 and t���� <0 then
	    ����(������ħ��,ѣ��,1000,2,15,1)	
        end
        if ISNPC() == 4 and �����١�ѣ�� == 1 and GCD==1 and m̰ħ��F <0 and ���.���� == 1 and fڤ�¶��� <0 and m���� <0 and t���� <0 then
	    ����(������,ѣ��,1000,2,6,1)	
        end
        if ISNPC() == 4 and SkillAfter(������) >1500 and t���� <0 and �ɿ��Ƽ���BUFF >300 and Ŀ��.nState~= ���� and Ŀ��.nState~= �Ṧ and Ŀ��.nState~=���� and Ŀ��.nState~=���� and Ŀ��.nState~=����2 then
	    ����(��������,ѣ��,1000)	
        end
        if ISNPC() == 4 and �������� == 1 and t���� <0 and SkillAfter(������ħ��) <2300 and SkillAfter(������ħ��) >0 and t��Ĭ <1300 and m���� <0 and SkillAfter(��η����) >1000 and bufftimeR(������F) <0 and SkillAfter(������)>1000 and SkillAfter(ڤ�¶���)>9000 and fڤ�¶��� <0 and f���� <0 then
	    ����(��������,ѣ��,1000)
	end
     
        --��е

        if ISNPC() == 4 and ft��Ȫ����<0 and ���.���� ~= 1 and ���.���� ~= 1 and t���� <0 and t��Ĭ <0 and t���� ==0 and t���� <0 and ���ɿ��Ƽ���BUFF <0 and t����� <0 and ft��������<0 and t���� ~=mؤ�� then
		�ͷ�(��η����)
	end 
        
        --�������
        
	�ͷ�(��ҹ�ϳ�)

        if t����<0 and m���� >0 then
		�ͷ�(������ħ��)
	end
        if ���.���� == 1 or ���.���� == 1 then
		�ͷ�(������ħ��)
        end
                if ���.����>=8000 then
			�ͷ�(������)
		end
		if ���.����>=6000 then
			�ͷ�(����ն)
		end 
		if ���.����  >  ���.����   then
			if  ���.���� >= 8000 then
				�ͷ�(������)
			end
		end
		if ���.���� >= 5600 then
			�ͷ�(����ն)
		end 
		if ������� > 0 then
			if SkillAfter(������) >  SkillAfter(������) then
				�ͷ�(������)
				else
				�ͷ�(������)
			end
		end 
			�ͷ�(����ն)
			�ͷ�(����ն)
			�ͷ�(������)
			�ͷ�(������)
        end
        end