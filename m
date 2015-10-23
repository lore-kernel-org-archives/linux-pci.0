Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:12445 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133AbbJWFp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 23 Oct 2015 01:45:59 -0400
Date: Fri, 23 Oct 2015 13:44:52 +0800
From: kbuild test robot <lkp@intel.com>
To: Matthew Minter <matt@masarand.com>
Cc: kbuild-all@01.org, linux-pci@vger.kernel.org, bhelgaas@google.com,
	Liviu.Dudau@arm.com, ddaney@caviumnetworks.com,
	lorenzo.pieralisi@arm.com, Matthew Minter <matt@masarand.com>
Subject: Re: [PATCH V4 17/29] m68k/pci: Defer IRQ assignment to device enable
 time
Message-ID: <201510231321.Hui9sTIO%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Q68bSM7Ycu6FN28Q"
In-Reply-To: <1445576642-29624-18-git-send-email-matt@masarand.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Matthew,

[auto build test WARNING on v4.3-rc6 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Matthew-Minter/PCI-Build-setup-irq-o-on-all-arches/20151023-131018
config: m68k-m5475evb_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

   arch/m68k/coldfire/pci.c: In function 'pcibios_root_bridge_prepare':
>> arch/m68k/coldfire/pci.c:331:18: warning: assignment from incompatible pointer type
     bridge->map_irq = mcf_pci_map_irq;
                     ^

vim +331 arch/m68k/coldfire/pci.c

   315		rootbus = pci_scan_bus(0, &mcf_pci_ops, NULL);
   316		if (!rootbus)
   317			return -ENODEV;
   318	
   319		rootbus->resource[0] = &mcf_pci_io;
   320		rootbus->resource[1] = &mcf_pci_mem;
   321	
   322		pci_bus_size_bridges(rootbus);
   323		pci_bus_assign_resources(rootbus);
   324		pci_bus_add_devices(rootbus);
   325		return 0;
   326	}
   327	
   328	int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
   329	{
   330		bridge->swizzle_irq = pci_common_swizzle;
 > 331		bridge->map_irq = mcf_pci_map_irq;
   332		return 0;
   333	}
   334	
   335	subsys_initcall(mcf_pci_init);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--Q68bSM7Ycu6FN28Q
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICDzIKVYAAy5jb25maWcAjDzZjtu4su/zFULm4mIGuEnvPQku+oGmKIuxtpCU7c6L4LiV
xIjbNrzMSf7+VJGytZGaGSCZmFXcirWzqN9/+90jp+P2dXFcLRfr9S/vW7kp94tj+eJ9Xa3L
//f81EtS5TGfq3eAHK02p59Xr4/vf3j37+7eXb/dLx+9SbnflGuPbjdfV99O0Hu13fz2+280
TQI+LuLH95OnX+dfYiZZXIxZwgSnhcx4EqW0AT9Dwhnj41D1AZREfCSIYoXPIvJsQZB5XLcq
HrMiSmeFYLJuTdKCp1kqVBGTDJp/92qAHxNvdfA226N3KI/nHp/ThCGoHiP8/HRzfX3+lY0V
GUUwFZuySD7dntt9FlT/irhUT2+u1qsvV6/bl9O6PFz9T54QWJ5gESOSXb1bagq+Offl4lMx
SwVSB8j5uzfWZ7PGZZ12NYFHIp2wpEiTQsZZvT6ecFWwZFoQgZPHXD3dXZZFRSplQdM44xF7
evOmpkDVVigmlYUOcFokmjIheZpgP0tzQXKV1usACpA8UkWYSoXbfXrzx2a7Kf9szClnJGvO
VQOe5ZRn1LIOs4GYxal4LohShIbNcwxCkvgRs3TMJQMGOpMUSOwdTl8Ovw7H8rUm6ZmX8ARk
mM7O6DTLr9Ti8MM7rl5Lb7F58Q7HxfHgLZbL7WlzXG2+1WMoTicFdCgIpWmeKJ6MmyscSb/I
REoZbAMwWrTWcwmae7K/NBjnuQBYcyz4WbB5xoSyUlEROZGIZIViZ6lIFOHRx2liH0IwpjGV
IJQ5x8FFgKZgxShN7WsZ5TzyixFPbqkVzifmH1bWw+4BHAgP1NPNfYNnxyLNM2kdkIaMTrKU
JwpVgEqFffXImTKDvdlHkTCMrxlbT+Vi1kACu2eCUdBPvp1KqLTslIkm0Hmq5VbYO1NapBlo
NP6ZFUEqCgn/sBAKFkJV1NBUZMqKnPs3j3WbYZf6dwccg8RyEBVRN8kxUzFwkh4e2KUB0Ru3
NcMyGu2XfUzgt3yOpWXtmYCTatiDUT5uLDoKgEkFa4BBbxZB3h4+yBWbWwnIsjSK7IfHxwmJ
Ajvd0YgIBwz0faIcsFEWnLdvnzQEBWaFEJ5aiEP8KYf9VkPK5p7xrLSebS/lTFXKi085F5OG
DYSpR0QI3jxjaGK+z/yzvqsse1buv273r4vNsvTY3+UGNB4B3UdR55X7Q62cprGhR6E1HpiD
BjdE+Qj4u3WeaGuIAgM2aW5FRmRk42oYoI2WjlxyqMDH8IkiBZgkHnAQR+5QbKCCAx6BbrZC
cwCPHCpBS9Xj/QisLLgk4wT1A0V1blm7xqVRg6+JoGExI0AqsG9FRgSc69ms/mpJPOhmUGAi
VYyC9nINHqe+GVNmjOKWGwed+nnEJLKIliBUQYPQGpiCrgbJkDmMmvh3PQChyizY+Cc0nb79
sjiA8/jDMM5uvwU30pjFmrdxmSGRBeJXB8AKl4zo3Z3tMThgwDQhE8BjVhYhYFmCtKMfZIz6
57qz4yaZTRPqVIreIrGLc4WVJ0MY1SHaeaYaQQp68ZUc2z5jcjtjVmAUIGFnuVHlV1+6RCOf
BIOWZyTtkzXg4Dr9g/FSbCy4cps4GvsgbsywfIudNY9ki/1xhQGEp37tykOTb6CH4koTzZ+S
hDKbpouln8oataHaAt5qNu5f6snl9xK98aYa46mx90matqKDc7vPiN6E3YOpkGjwybK+szdc
Dd1prfo+vdlst7s6Dkg0xTBY0swHfiU4pk1PX8MFrKqCD8GsfWcCvTZH5yaw6l3bWnAMPzOb
WorjvKFl4hyYNfIDrq23Oer14ohm5RLPmNb9dlkeDtu9ZoDm+WMgSSMiJbcGBPXoZ/yH+79+
tqT84f79T9tKH+5//rys6jK/3JXL1dfV0kt3yJCH7loC8O1ZbHeqBzhUqz+fS/ip+BisMARp
GDo2o1MfFLJxc+8u+4PZUGlChAomJ+As8hvWtQEF183n08f7GggL7TiDFMIl+HvUaUaHoDGm
Pm844E9Pt4+P1/q/C0wPoBlDhaIVjFRjp9nzCAxXT8DjxfL7alP2xRsPb8SYs4PlFHJnmHE/
0WZT9kYTJPaW9kQFgNBcPF3/vG40oY8NTbft/U+1Me6ia/pd//z6tY08YSJhUYWsB6rWkvbX
UgcKaWxhHliQGa0V/qVVY2+3o9MBYsjdbrs/Nse+hLeSONId4DA2Z0D/EShh96AApv06JxSU
TwS8VPG5jqKcuFLldguDQJ5OnTAIHNwwIrnfNzWUe9+3hyOewXG/XYMN8F72q7+NKWj6v0G5
OJ72ZcNCgNVlcYZqPGEtQlXt0zQCB5gIux2ssGzmoaEXGgIcEaW1AjrtVcrqrCsYmBodrWVA
Wq05muvRYo1Sgh3RNdIotgMnYwbTjCVEhgp8PR0DnN2qLAInN1NaH4CmkU/3LQ+eti1tzMeC
qI4jm4XPErSiLwplnOaBHBvud/x0c/FkIJagDfU45UIVCtRg3trqRNoE5mxZY6AarCzRa3i6
v/7w2KIgBMNah07iliqLGGhx1GfWY/ycpande/s8yu0O4mfti6aO3IcfMX0QOssy6QQlmiHZ
z3J5Oi6+rEudn/V0WHZsMCb6v7FCT761EQiaCz+Psws90NUPwSkAN9TmPJpRJBU8Ux0jQdJc
tRJZBheb7U6fgcfA2VazLRgurJWEZf1smF/+vYLo02/Lp86IgoU2zQ0TcTYQJhoNWZQ1w9xW
M1Bcha0UKDiyKs4CG2HAqiQ+iYzU19KshwMDFs8IEFrnuFpO0kwHFVY3Cdlhpn1nGym0Yi18
waftzl0ENhWuzBXIXfgM+5xyaQ0fL3lzYH8Yh9O2BkF5lCFsy8fkW2Bx2dHIvOjjaVA+Vi0K
wE+dUXaERQCFCVBPaR/djdWIHgawiPirj6HXmh+ATWKTftc5DLVfbA5rbX29aPGrFQbgUBCy
AFGaaRPd2ImtAmXXA4kLwJ0QEfjO4aQMfLvqkLGzEy4Ygg03tS5REVoSIpXliMHtuAIv4ypY
Lw7fPfDHdg1L2TyegLcp9ZH5jOokSrsdmK44N7cPGMI0cJ51nrMTRTewUJmPSDIpZtxXYXHT
HrwDvR2E3ndX0IG/d9Ktu4jHf4t5d+vYFm6edzaj225tZOL3bjFBsHvlGgyRegS2fmApJPZl
X4wRAmrQ5jWewbniUXsXwEDdcToObluAR7KT4alCgd1utfl25j20foYZF0uM2VoBGi4FnBPY
IpIfQuexi5nQNelcAzaaqySlo29OQR3l825fTdxiKsDbsqttPQF4dRiOdHcpy/XXt+iTLiDs
efEAtVKvDZlrDxTTh4cb5zwy6szS2eYQFP4MgbUivMUV9uz16vDjbbp5S/F4esa7NYif0vGd
c4oEDK5bryWsC9ejRxl4ed7/mv/fgqcfe6/l63b/y0VC08FJwYwPnmQ+ssceqT3fBgoX756t
STudRmu5V1VmLcmjCH8Mpt8gpGFS4rHx7O52br8E0Vm47FNBuZSFTwYH9An98Hg9iJK77jDO
CBT8m4GrxTNaBEaqz0ZiBNy/OqDH++J9KZeL06H08N60AP8MxJ+js2i6rMvlsXxpnuyFdtPY
7sGfEeT8vfs0KuXVbzS3HE83jzaYzhvoOKP2wn3QeUU2UdSfOi6MqgHCYbCQ7aM1ynF1WDb8
sNqBy+P4GdN2dl4MSaIcmliOMeSmdjOjeBBrl9V+K5bQKJU5OMMSPU/XtWqYFTyyJwOkS+/Q
267wmMiIZWhRDv1sh4EUH+7o3G6i6eivm+veXvQQqvy5OHh8czjuT6/64uvwfbEHVjyi34gz
eWtMTgGLLlc7/Oc5NCHrY7lfeEE2JhCq7V//A928l+1/Nuvt4sUzFSBnXL45lmsv5lT70kZN
nmGS8sDSXHcJMYXhAtLF/sU24KWpphIN7QdB55G+RnECTe6pIJldCSIKY6Hr4or7LR+Q+/1D
kFTyswmsz/fMJwDE65BWQoxwH4tChOsy35HK0mN1EmK1orfLZJDLzt2iOQLGmHdz9+He+yNY
7csZ/PnTxpyY9ZxxhxSdgWB85HN/is3udOzTpRFjZHlfTkLgCM2L/Cr1sEvDhQdZ5Y3LM/0T
/0aBa129agAYm0ze2gmpESI+GkYQZDYAJRGEIqQYHgKgmP0aGkZQ5xhjEjOrNqEg5QswJ/t+
ZKvUc5MWU/vcecLnH94XmXq2uZ0RGxP6rKE1uevGyrDcPjy2N0MiTDiaHISjRCRJP6exnbt1
6Q7YpWRiWRGYlVbKEX5PTEPlk+5Xi7XNe6rW9f724bpHxWS7easBB9Nd60sLp1Zj5BCIRlxZ
S1oMRrv4o9EIfyUyjfrAmAa2NtBouY9VhE83H27rTH0DoR6wu8yP0mEuDVhSmswdFUIGo2Ls
j4qMccv/AvUf0YQjLWDAInOLEIADGYED7JwDGL4qy7GnMrKYF6bczu4hhzMQ9MR3OBmYCRDK
vnxx9+HR7n1ARBdx6hgS1MpQykxR+JPZu855FD2P8n7iiN9Sq451lLFJhzGUmUM4w7ZJMhcU
mbTNmWX95WFbVbq7hcC47mWgKvOW6+3yRxfANjqVDKEuXuxjPSO401hyitGvLnsCZRNj8Owd
tzBb6R2/l97i5UVf0YNE61EP72rtWBV34B1jLsGxLMYZ6OCwU/giGFYjMQ001ZhnbrA1VOnN
fl4UgXamwl66LK3vJps48HWx24Ebp0ewaDUz7Yxk9ssoDT4nTjGOD1LhYG+9Ehre3dzYozGN
MJ2/f3joLzXwzQLLnzs4m0beG6+uepD2kCT239/c2LMCGmGk3jsCRA2OI/D9Qzdc+PTu1rGn
mX3aLJ0xUcgcZNdxL6YRyNQRLMyc1akhEzGxpz9nRNHQT20FpVKOYEopubl9N4Zuu1ktD55c
rVfL7cYbLZY/duvFplWIAP1s0SKNSW+40R68/eX21TuciwnwkrkVo9K2v2lO/rQ+rr6eNkud
lx7I/gS+OwYLFdU3n9SeXIkyWnBqP2GESQcM5/xIks8FBa/bIX+IM2FxFjlSNwGmKB7vPvzl
BA+xl4YrOUcP1Ikg44drOxuS0fzhuh/vtXs/4z2sE6wwOXp39zAvlKTEkZPXiJl8fPhwYze/
GiEeIGFPLdQmjo1zUDuunBTzOdGCZvNtx/vF7jsyeS+Wmo4J6OeG9q0aipjMQepzibmOWgeL
fu4y2C9eS+/L6etXcJ39fjIicJSPETqJ8L1HEVHftvDa3R4TMEnKfnIS3GZbyU0Ogp6GlENE
olTECpYAfRo31givJm03XkoVQ9oKMPO2BjBXS9CmHdxODQG2Z99/HfCBjbliskkyzgY21+HT
Zxo+p4zbCyAQagxJx3dpYxB/zBzhysx+MHHs4G0WS3zgYF8vm0Ew49sXYmpk+YhHripB8AYL
XedlhUJ4Xt1S2ofP5z6XmavIPndIm64pMD5j32WYrvagh22nht1MJOwcFU1pR8ardN1yvz1s
vx698Neu3L+det9O5cEeHkGg4KpQpqFIY3bxQfqLv8T7crfaaB+ww59UN8rtaW+3MUTFLCoy
bmecmPBolNr1NE+x7M+lhgQ4Ysdyt98urWGl0jXNLIbgRbTrJUzv3evhW3crEhD/kPrBjJdu
PLx7+LO2vJbrB5knc+5ONcJ4oOrtrkqMXikWx9nzn3PltB/6zZKdYA7uTJRdOiFkL1wCn83s
e+IZ6FpnL3CzGVbvJ0qkkSugC+L+eaDuar5WasZ3xkt2KDcMNLI5KW7fJzFGQXZ908ICXWY3
qOBLFZM0IRrDPSN6mdTx4iymfc3efP7wCv4hhFg2MRXETlMVglViYpRGfSEgm5f9dtW6tIBQ
WaTckd2Zdi5b2oW0luy/vioJifCxMuVfpbmMHcfiInOYjdQXcPVtEbQCsaqpmGO61SUKd0Vg
Jw3A7l0wwTi+aZEu+Ec3aKQG+iU8CuStCxrcunvi6y5iV3UAAtefz8G82cMQ/cYBb0tdijyQ
Sap4YGdZfwDGDUy/ALKPTAZ6f8pTZc93awh1FJVgDWcgnWcX4GsSBywFGwvmubDE5nSx/N7x
F2Wv/M6A/bdYj4L3aMiqNafWZJHph8fHa9cqcj+wrcBP5VVA1FWiXOOaBwaOUafQ18l3qsdZ
RnoP5ellq8v5egJXXXS2K0yhadINXprAy/O/dh9dWAgRNHdFDRqLhjzyBUssg+M9T9B80YX5
lVaxaQ7uZTTSM9mdFf2/HhnOlOWSajkxD7haQxPfLZYkcMPCQVAW5W4dwgb0ixs00OtjMKB3
onTsgFDwThwg+SknMnTx4ty9lJgnoKv+AViMcD86VCpuHvGdGwc7Nnc8bE3jAVJnbtinZH4/
CH108YuopuyUwuPCwcXBesVnU6Di7FvjdcoVe8OkynaBadDSpNs9c78zxhftTp00YLSivuKo
itO/L5Y/zAs73brbrzbHHzqX+/Jago+87b+bMNl8nd+1ySHEZ6grgCX11wzONcNP9w0J0KWa
Zhi/+6TZTLV93YFKe6tfyoNaX/446EUtTfveti6T1cUydcuyqtcD4MckjUfWjQdeBh7nUplH
3436eYGfWcCeTzfXt41tSCV4VhAZF93nyA03hPjm2YLj2idPwNhhxigGD88Rs+p9WZm4qsG+
rLjTRzJdXI+6McZEpt3a6u3pN+6DVcLmeeOMkcm53t0R0o25tiLC/oANh7o8Qmnm1P3yy+nb
t85rT2129JuC7j15Z3WI6K6NNzjp6CMQxKEMLw+MC8c8GgOzR0OnpN8NgTPlsmEGa2rnBQOs
vkqBD/mHJgo7NTlVnTvQ0IsgJD/tjMCEi823lpSgSsuxkr//IrgxBQLBIifm8w92g08SOGjg
rm55sA1eTEmUs/oVrQGiCsH3ANcNKldPJF0vggy8K+RtsPuQTG9zSGCbjNwMUBkXOGEsc7nd
+ml/nylMFSEmRi5M7f1xqDIoh//zXk/H8mcJ/yiPy3fv3v3Z12LnT9sM8Ql+p8CRxzIYRKUx
ymIEOxhAq+IKLMEBjREF7kp7/YQHmEZhaVb3Ey+dUSdG2mxKC+/3DBL8mWJsK1mzdqAH6S6Y
D86c8X/CcLxUNkAd7nDmqP4xOFQwnyWKE4thxS+l2HWZgODF+SEVaV7x43dQhnTxP1Jff2bl
XyENf4vlkxyQwuqMND+AdtZvXuyeR0XMggmRCpDbj8YkOUJN/YrZhmMoix/JAX9AlYdjh7a4
U33qhXTl/tEfq4pY8PmSmzYj/bkaJ1yfDaizYhgNbCS+iXHCjXA+3l9Ezn7cuK+QzfFljxsB
HZFkXL1IcqSREG8CiMqRbtUIIoSIQH+KyiK35uM7fkqloE2hNLSf2G2aBmJyQb/pHUDp+YHd
LRIFumzCnh2anWC1vvU1GjibIFutKtxzU0W5pzf77fb4dPVS/n31enz5gmr6+s25dml52q+O
v2wep3s1jOb4HYPCB3dY50VhHuoqwjG4g0Cr93d+jVfPRmhTj7ah7e90if/WcTU7DIIw+JU2
vewKqEkXpwbZj7uY7bbTEpO9/1pBJq698hURKLXYfh06gUeroVE25OxUf2ewfj2nB3pr0/uD
Z3Cd2YZXPKKy2dRie9IfBcJ+ODOVWNLN2cZ0Azql7WlMKwitReqyEVBP9E1IrpGvLDUnXEdr
RmPA8XuFqEDUoX5uvyuAT9onGByaA2buiOXZ5h3yjLULqUANptTDgenqET75KYgoe5UCoV5C
C/4nonzgvQY99+RdcIR4SpE6F1QEh1QkVPQJO8Nb5zkXTFieKHW7o/rzD/DQqM2RdU16UpN1
KiM1JZX7Fr1ZDPgmOYnko22nkaCaf+46uCQHw7S2EOYokUn6QKbml3EZvKewnoLk8/kF2oRj
vqpRAAA=

--Q68bSM7Ycu6FN28Q--
