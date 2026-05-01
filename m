Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FD2383C8B
	for <linux-pci@vger.kernel.org>; Fri,  1 May 2026 10:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777630436; cv=none; b=DxzUcPwAApymswEqoSMdryTpoj0NYWxlkwHOX3poPyiF4rrQWJfxBouDA3taLUjqzkfHLu52gqp4d2tLZt+tIoahpI2NXB4g1zWOiqnCbqRREiGFMgk+iLD6YodG5DyMRk9QG/760YM24yfLk6y5go48eLkqMFOgC0lwT1mXxNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777630436; c=relaxed/simple;
	bh=AsdjGnp8HXvRHw/HSq7ZdKNoutW4kyaugZl5jtD0mME=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:From:Subject; b=isVPopDUSo8zpWfxcRJpNeoXTVgGf8KnreeLPhTc7rMHHhFw7G1Q4EX6bVHeieo3H6sFhUijsXOIsCb70wZAyOrlqnGiw0OnNBkvoA0cLepSIiEPJDTHYop7udY3Y+MjSq1/03U+aBxquKS2kJbsnObPOLqyyk4aUwhE9Vo8ECc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=dittrich.m@gmx.net header.b=gIoZKun3; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=dittrich.m@gmx.net header.b="gIoZKun3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1777630422; x=1778235222; i=dittrich.m@gmx.net;
	bh=16yzKTQUD3CRRvLM0QgnqmHwri4wW8G8IPYyjMqOBNk=;
	h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:To:
	 From:Subject:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=gIoZKun3n7e+QTLeeJQzr/1MMZI4olGXilJWrG1L1U6pieyplvai5q3WCRqaCddB
	 HRyqWShkjiuWAqqN9oFzUd6s2VGO+xFlpZ7jv31zLvSOt3bUkcDpKEWarG465f2JS
	 PpqsgjaXhU8jxhZJlPE2QVW79IymYP0PDLe+9wiJ1odf8RuhLoPI8f1Kk3x17fdvi
	 4nEOIgVvKAg0yP+pROCHeXLcQjNyfeJWmhgw+Jo9+0ctnpkO4TcJg/sDd4MneR04G
	 /MLs3w6RT9JgnSdJw9FnGQpC9i2SM36iHa61sEUoRwzJbnHMmNjCXTzozRtuerjGD
	 sYb56pNabLRmarzrNQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1wB0aP29L2-008WdU; Fri, 01
 May 2026 12:13:41 +0200
Content-Type: multipart/mixed; boundary="------------rXTU10Ky280u0iP2PgAAnybB"
Message-ID: <a27da33f-96da-477b-b7ae-e7bcd3a34796@gmx.net>
Date: Fri, 1 May 2026 10:13:41 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: bhelgaas@google.com, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
Content-Language: de-DE
From: Matthias Dittrich <dittrich.m@gmx.net>
Subject: [REGRESSION] PCI BAR allocation/D3cold failure: NVIDIA MX250
 inaccessible since Kernel 6.x on Acer Swift 3 (SF314-56G)
X-Provags-ID: V03:K1:sFocw0CIIBP5VxyfqGXKAQlcUca/+a51xgUWoo2afoYteRJwUx/
 4BQIqzJ17VYQDZ32nVWfLDLD7/5uKoci/RMK0ZE1cCYlHqaR1NmsprvnWwmEQfUALSZIx/B
 Z+9MFoQxbCQ+wo8ezKujKsYqBrif2/GNjHPzLJMBmQmQ8wqX3IW2RA2Mp8fY8RhbbhR1Kn1
 idv3tIt+nT1yqkEb6Nasw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FdPHj3VuBtM=;TeT1bBaRW+DCUfPz4upDGEzqAFP
 LU9Ga0PCABphPlEmkHcNxMVbCkbFLeUCfPz6M80mKD/jN6O838oBtra8s+Le/gd7HIKs/mBJD
 BFoF/PdQzUgi4N5ICff+UuwBGE9N+UcTAyObXBft6LEsxubIC2lKPZoFv+xFgflP7ldfP2dkt
 QN0Rh0HkPUhMwGjwq9JB5z0vbySI6oHBbPVbcziqQM8ytPTuaP+p0q/lUszBOrabke+oJQ6uG
 NV71ymeOUvVEQdOMChb3xYam9+R3aWdR3YZ1nzutgRukSHBEcEFA1ZYHsD1QrvzMEUxQfSjY1
 oYq0uQtE7PbKrohCO2Vy/hDefOLHoUbr4W7sSETR0hyjTGQ/0WC3Qfev1eqdsD/gVsNyqKpEl
 0tBk7gbyCRETqKFJ3JmWpAOJijNYJ9M8lvY0cML9KrAW2fn4NR1BCyHAjKF6Ib3Spz7S5wQWv
 zqHzfegWKlxALYkOhNISD161JICFN8XaeP/w1OLGvD04jR0dSouUBIa0OaOoYgNtqBDOhMslW
 OcE1t27bis82ZDSqWzbRpPm08nr+eXhc5nAoAdlM7KmUgRNTUUQLD1pH5KhXAXF2m/rJVTKLX
 mnefx7EuibRBBjWDet53mXvXjx5F+ViHoiJAGs9qqNEwW9W6miu7LXG3iCUrjwK38ATZ92Vt+
 Ci8f3iOeKCU60gdzZZxDL6S3tu8G7uIwDTGqsHQdpOy/knuwkp+TVd1jRHY2aRIKSYxUhexkz
 v/jrw943F37oUuF1v3LquiQkyvhbYw5TCSUNWjrGmcsXWGL1sHwFiNIg50Kp+yqtwhNsmnGFr
 C3KgGy9Gc/gNrbEa3oUdAQjW9Te+z0aTfGVYd7yjSkuP2/1ytiKCdTqX7T2bHVHjSB4hyHJd0
 6RDLLWf/D5maqQ5htRU+WgtGvg2iySSJ/NrW5F0uqNkiUs8B/MYsAyOp+jVh9orKvhafG17/L
 WRrYMAd2kdJRmImCg2gP7HU4o6sQVQm/KBGPwWoO8ThQ6lSTx9nWMDFiXSXBgG9+0Lagn78+3
 WIpc0K9BzIcJxA75jqCpxEGyDsHN0KoDXJveiHFpifntgZXe4HlJTRkCpGvo7/ZHfcWGoK7iU
 79XYj0CtHnB3d0WKH/5LSZEYskoOZYuxEjdDF2PRhlRgkXhtoSkcko1F79ys6sO4iEgrT3b8t
 VzmhZrmEAwlSMWC+rtRDWtOgvprHnC16y6a9aGJ42lxPGaLxRQ8MLfAlnKBzpwlGJTjW+QzPB
 ih9Z13zh546wub6VaESUkpyQekUN9ld3JLvTRUhrzc/TY/V+zPMKBH0xlntkSJbrFWeYGq7R7
 pZcFNjgzF2uomEx0V3wmqDM53WBW6DY2yOv5u7SoX048Fhjffin0/4Duy3Gxreqlct/Z75DbM
 esIhw2Pv2G69TGJicS6FoVY7ggYn0r2+gtCYm5w30reNioDFqiSvF47oKv+npp4i4H7fI12tL
 CvvkDdlHs9iyYxmQpwcC5fXGL0KacyTavn9Di7rqbBdizClkvGOJniJ+/xVlKNW3NLU1H0OE3
 EEBzjVayQbz+4jvBANTRUJPLJ3jBn1sdByn2w6hlTVy7utNZQHR/jhyt1hAfpT/V2Le23KJlU
 eT5f12QZ+T0BzQYf/qPA0P4Sn97BsMGDmi+ixv+dxmVRdenJLYEtLg1GWUOVAVW/nvA+0OpOF
 9eePuQFoD2noBnyqiIqwm5rET0GsVY4GwRWhTDX1sJnsSSgS73qoaQQJW+C529+SE844R7+Bp
 p+FrIvnlsp97XDmx5Lrj/AtuTQZ14RPUD8PbNR+oYukBgLJxVQCcTR9nQ8Wl39X9zrsEni1vN
 /MFSXwgjiQnSICgc/rVQTSHshIFCl58jgx427tmLdnsIW4PstMNMcYwCCvowXw4Jsb/DY8E63
 SmcikDG4gwOBjVo/x2ags0YDZdG2aip16z0tV9d7zXuRkIq6AHHx4GNNc3RN0ZLow47z/Z4LC
 VxtVwwYPorftAqKxjhxxou5Wqh9uSeCcyMK5dbETVNe2QQVSaPew0O3pwkp0F74y8sFR2Sn6G
 Qnk8ectrm8gaRihPAyp5f7VuH/4ToVZlc/qBaiszR+pBOaow3aOSO9IHAd1pxXL0eTqEda4b0
 5w2L40ukS4SUD6Yeq5rAvT7GaWe5Va/Z2lwUD0RR1CHWFQYmfwkl1UHE7EpFiIJtvjmkRY9lV
 a/K0pkMYmOm3v0gdaORukSbqvumx1C3sq4b0x/ymVY5wsiCUdvhoGGRxqQ3Hczwu+IUs3WNjl
 lJY//+OvtoGf2HcTodgqOAnoaMUZACufkuViSkAjW/x8kDqDAxqxM42OjYDuaxERKSeiQPO1C
 +E2K/R3O5z54JcNCXN/dba1P/zSuVZAqZpgmmkvJtoBl70Oq+qGqK072YPWNX0o2crpTrygAU
 +zzPGoA6uD0cuxW8/044C5Wgp05mPWBQQTzK8UGmMhBs2cfBBDzOpAwN4D69kGfSTdcGh9hA9
 KSVmIa0YlStASGo4zRIoCBJyJAJYN8igAznbyeF5ScW5yIQThXSecd0vbgSOUPeFUja+oWVO5
 xBoxut6dE0sSRdJJQeXpcJ2y8OstzjZgvDeVx0p55kxoGSYOiXCfEi6lfenNi9wlBzBewhtFf
 SVbr/i/vYld45OFdOEwVjuRnFd5VGNIeyaS4ajX6/ryo3dh5fyVAMxFzt94v4GU036Za6MrXg
 qJ1g9UDyUCjWeMSiIbjzvqaeHSBfxW/3X93dzminEt6aqNxljOd5GXy/aC1ib/zgSPoWzQ67z
 ItqP6D+EMdix8DAIh3XYtcpaEpSMffia2gi8fe73MlKy06OsJcGTA+Q5FhmtGcHu5NZEcrwPs
 wvDAgQ0qLP7OJLEgyG2I7RTxtwDuxuhDJG0oPnXp9rydIGYMHLDgAJVwlt4mJ5duoPS11ofru
 F71RwjUXwxoJaISz4xO9hX1b/PttgeGVhBiE3kOnvtcsfS1niQE0ZLMhZYn+cNs50l2855dlf
 QV7cmUtgk+Hco3XkuxZ8U51le5ubJxESpu95PSDwNJeMMK5aBWzpkGoo8a6PtrBBMIxwyCcwW
 6b6sxIzHyXCKcqTNXKWSOx+/R4RT+BCIt1dmPSbeKF+toBofVpCCG45FrrOGZ5g+QKIYPLWVr
 Wb+6PCc4hb7ct4dDYpjn3fFshQbRBO71bsSO6KlnuX/sO2uFScd02sTNQxcoMDnEevzyXJ3Ae
 PVkXn6aE9xtgXOIAMjyjSHB30lmgwNlwYroGumdmb9DecAfi6JYdRRJG1jXOGhKd3IwIrDwOH
 SbEJa8B+XHwYc+pfhvUf8ktUqAd1CPUInc/jBLfpkgga3cLPHN9arpdiAnOm/QKdY3O/49rPD
 sBikhCLtmI9JKfGMPHjj8Ijj1kP3VvJs3no7YQgr6DVivx1maSFdzy5Os3tHdoCVS8kah+Ri+
 eSUzMmLGS5NouxXndJ6gAJYgK+xYXemJUg2BPDOi4HLnzXaDky4beQRsCKQWPBmsfEFZnBkfk
 w2oRv+SpzyU87b8iTaHFIwXFcp/Lr4Xd3NBbGp4OlQvHkgJI3DY5Ml/rCE/6/QZyNHopx5FFx
 2d6PSf9oj4EAVH3QJgVk3n93X7GAsbaTDQOXgs7F8wdwzBUMPIbecacjMP2WpxAElfW33TfYd
 sE2ZyxreAuQJOdJMlZKZBDzEpscrhE+FAKog44nRDXTJdPdT4qK4VGOqrUcqVsT0QnT+rvndq
 lNUvwJSK2l5p05gUiaPAX93cxdO4aLePmSKXva5IujX/rBQPwiMKc0kBc6kG6LoU6G0XSdUNN
 B2N/T1yCBsg/0OKXfr/G4MVVQSab1ZGgGO1fF8+2glpWh8qgE+9MPLOzwmtXy78RLfeCqX9n2
 tdJvU0wZm3WMTJ/pEjYuL2fGWd6w7a7si/JeAgKDdm6t6F6GCSplxJXAA9zm/+VcqFF4JjKm+
 YsLWy8RLcH1GHR5fFamGE43bnFh9hCdFToAbvn3s+Is1eAcz43CJD6gW9zwyiUGv9EzO+GC1G
 V6jWqv1sgUpxrlqa2zeczQM7av2nTSSqm7QUk+aP/83d3XM5jh4tcGWfQ72hstwSYy90x2t8T
 v4ziH9LGkasif0E46wHzJ/wC7fT2dHntHxOEuKqtibhArg5RFWHTc2jKHZvUoOqnbB9XZqi2y
 94HjdMJvcjKT9S/krSNxjcHXOQRAC5spK5/MjMU83GNLMip6T7aIJVqRl48CwENWUZwOFypXG
 K7s0elQyQ0wrnL5NMxTOX5T5q+CS9D4uTnlJJ9kcbhJcgsthE75c72AS5x+MhqPO5EVopu9cz
 cZ6srt/2/yN0qg+1ZoQODSy1C2tdVf1GAr0Ivt8UF8vy1nStSzW8lawRBKx6bER+tbe1CVwcS
 ftrHFEvR0/hmosp4JK0EYbWBRTwtX69C+cVIJjCsmm/D6hSveXoiREwzcct930YolNeP6ezJb
 k+MmDMTD5f2WusCjM9plfm3UjMhOVI2l/wor9b+IkCqvFLkZkSZk23yyjngcrULQLgpuXHUVn
 vl9giyprwccDLiJgKI+1EtKGuKdbYKRPvmqw6UI1AYFg96atUMAoousFShAMSwg9TN7qffEXR
 1qVk7Aw2pANU5SlASvzZhApliNZi/iQ/CBpq/bm3z1cKt7v5p64LP+LBJomNy3mRCd2847lU0
 hbNQQ5Xei5vdp3aomyl3i4/Xyn/AVH7EY3JI9Yk8wfXsMJKnYBIgPfMxH2mPPyaTQCYBQ7c8b
 nR1009PY1Jqrg9bA5BmobxqaunEQuRZggCe5op7vmf9pOmP8lYvqNuCDeqFFcXcH75+WwfZdR
 jwAWUjFrhwDbYHouF6JLJRGfwhzr26gU4P1YNhgWYeBIt2AD6wllJ5gLY+L1dlhyL87nha83U
 vmDRwqn/uxJa8eIcEQZIUPMrfUUf6RJTtea6/QxO/7IAUegpn2nQycFOvHnnISAiRdTS2/1gK
 tLA8d/2A4oYubOgm1aaJ36K9eCd6lAxShcyJVmhDrI/X2u5A2Ng9uwcpqDGp5E7m3IGbxfUQE
 inHJgknW8l7ul+Pa2i3jxhl60Ztvb7G7Is/iinLKI2kyoUHetfm4EZb/MmmbxiqpttiM4eHZr
 FPW5Wz6ptVE1kEJImYJTU/JR3/3OViwpX38XPxbPsClIxqACygpHhywM9ULNmFc8aFwG8UlpM
 1QFabl9LhlAmKR3khzCH/JgUEYvTgwv9upe0LbAHW64R9BuFlTafTi1y4jhGPGo6YH0vKt45B
 pn5Xws31iL6kChLxqG5m9g+2bav8WvXB91g30aVm2xrUAibkr2fW+V/Am+1wUl9Xiv7piE951
 qsoCovj6pir1CJkYzQB152IJvrXdwLE1GotP2LxWvqI2rNNZ6wUicv+RaofAdROdBhKq47/Hw
 ANOS8GSDi/PEQQnddEKXnpcCB/deh5xmXOKRL+LDLdleTNAzDk5ObgiEZwsSYlRJFvZdzAl9i
 XYcP3lmSw3i3JiLS7YGI+ylLKkBS3xP2w6TyTqHe8xcUCtrwNspb1ppraNZZRvSOU9/nAjTYO
 nnU3agxiupjMHSUEiRngdCvp1PSgCImRdbLyz/kukm4ZfQO6kxg9p+RI7vRXZ+VUVqsA4Q99J
 SRvIFTaJSU/J0AQ1uYIp3vOhKu1IxddxN0sQqF9zL6edg/xMCx6NYBkdvTjhfOLFlY+SCP5VK
 DQzX0ae4sNuvxE5rJNda7HZLdDYGyvmVswFDn1jwfTh4fYnrt6ZhjojhqPsP6Jb+NM+wfHeXM
 gzHYh8FWt0vIAiEi7CVtGCGQ2LzeFYkxYOAVOcEb/eR6Xba2ncySpMx6dlwRYz3BVLslFjUTi
 lcvk+9FsxYaWiUI0GxtRi2rWAknEXsbW/1gjx8Ba32wfuFOQhOEjNOruHgmlLqJFcXi0QUIuN
 H3XZwAX4l+c1dp1m6taf6gs64Hxh8Xa2+T31YjTSSCvSDmHHUeN62sSc2SXJlWB7uqH38Awx1
 0MJc+pPBrYBdbR9brLy34MIcXHKNxjrJt5ERRAVb7cyUAOb3eeNEVlrTB1L+0KLwrso4kfpFp
 fRXfgSLJ4/eSK0XxKwoorWWgEiNvyOvZPhS7E=

This is a multi-part message in MIME format.
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: multipart/alternative;
 boundary="------------SRsI7Sv0YK4GahUUcxwV9vfx"

--------------SRsI7Sv0YK4GahUUcxwV9vfx
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Dear Kernel Developers,

I found a regression and did my best to identify the issue and find a=20
workaround, but I am not a developer. I also published the regression in=
=20
the NVIDIA Linux Developer Forum, but it appears to be a kernel=20
regression and not a driver issue, as the latest drivers work on older=20
kernels (e.g., 5.15) but fail on anything 6.x+. I did not perform a git=20
bisect as compiling on this i5-8265U - because of its low performance I=20
can only compile one kernel over night.

**Description:**
The NVIDIA MX250 GPU on Acer Swift 3 (SF314-56G / BIOS 1.14) is=20
inaccessible on any Linux distribution using Kernel 6.x or 7.x. The=20
device fails to initialize during the driver probe routine.

**Symptoms:**

  *

    /nvidia-smi/=C2=A0fails: "Unable to determine the device handle".

  *

    /lspci/=C2=A0shows the device in a broken state: /rev ff./

  *

    /dmesg/=C2=A0reports: /Unable to change power state from D3cold to D0,
    device inaccessible./

  *

    Crucial Error Log: /NVRM: This is a 64-bit BAR mapped above 4GB by
    the system BIOS or the Linux kernel, but the PCI bridge immediately
    upstream of this GPU does not define a matching prefetchable memory
    window./

**Proven Regression Status:**

  *

    **Works:**=C2=A0Ubuntu 20.04 (Kernel 5.15) and Ubuntu 22.04 (manually
    downgraded to Kernel 5.15). In this state, the GPU is mapped **below
    the 4GB boundary**, and the driver (v570/v580) works perfectly
    (glmark2 score ~1300).

  *

    **Fails:**=C2=A0Ubuntu 22.04/24.04 (Kernel 6.5/6.8) and CachyOS (Kerne=
l
    6.13/7.0). Any Kernel > 5.15 attempts to map the GPU BARs into the
    64-bit address space (> 4GB), which the Acer PCI-bridge fails to
    handle.

**Attempted Workarounds (all failed on Kernel 6.x+):**

  *

    /pci=3Drealloc/=C2=A0(Causes initramfs/SSD failure on this hardware).

  *

    /pci=3Dnocrs,=C2=A0pci=3Dbig_root_window,=C2=A0pci=3Dno64,=C2=A0pci=3D=
realloc=3Doff./

  *

    /acpi_osi=3D"Windows 2015"./

  *

    /NVreg_EnableGpuFirmware=3D0,=C2=A0NVreg_DynamicPowerManagement=3D0x02=
./

  *

    Switching between Wayland and X11 (No effect).


**Conclusion:**
This appears to be a PCI resource allocation regression or a missing=20
quirk for the Acer SF314-56G bridge. Newer kernels ignore BIOS limits or=
=20
fail to correctly negotiate the bridge window for 64-bit BARs on this=20
specific motherboard. Currently, the only way to use the GPU is to pin=20
the system to the legacy 5.15 Kernel branch.


*Additional Findings/New T***est Results:**
I have further isolated the issue by testing various LTS kernels on the=20
same OS (Ubuntu 22.04) with the same driver (NVIDIA 580.142):

  *

    **SUCCESS:**=C2=A0XanMod 5.15.75 LTS. GPU initializes perfectly (rev a=
1),
    no BAR errors.

  *

    **FAIL:**=C2=A0XanMod 6.1.77 LTS. GPU fails with: /pci 0000:02:00.0: n=
ot
    ready 1023ms after resume; giving up./

This confirms the regression started exactly with the 6.x kernel series.=
=20
The 1023ms timeout suggests a race condition or a change in how the PCI=20
bridge handles the wake-up sequence from D3cold on this specific Acer=20
hardware.

kind regards

--------------SRsI7Sv0YK4GahUUcxwV9vfx
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>

    <meta http-equiv=3D"content-type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <p><font size=3D"3" face=3D"Google Sans, Arial, sans-serif">Dear Kerne=
l
        Developers,</font></p>
    <font size=3D"3" face=3D"Google Sans, Arial, sans-serif">I found a
      regression and did my best to identify the issue and find a
      workaround, but I am not a developer. I also published the
      regression in the NVIDIA Linux Developer Forum, but it appears to
      be a kernel regression and not a driver issue, as the latest
      drivers work on older kernels (e.g., 5.15) but fail on anything
      6.x+. I did not perform a git bisect as compiling on this i5-8265U
      - because of its low performance I can only compile one kernel
      over night.</font>
    <p
style=3D"line-height: 0.25in; margin-bottom: 0.13in; orphans: 2; widows: 2=
"><strong><span
          style=3D"font-variant: normal"><font
            face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
              style=3D"font-size: 12pt"><span
                style=3D"letter-spacing: normal"><span
                  style=3D"font-style: normal"><b>Description:</b></span><=
/span></font></font></span></strong><span
        style=3D"font-variant: normal"><font
          face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
            style=3D"font-size: 12pt"><span style=3D"letter-spacing: norma=
l"><span
                style=3D"font-style: normal"><span
                  style=3D"font-weight: normal"><br>
                  The
                  NVIDIA MX250 GPU on Acer Swift 3 (SF314-56G / BIOS
                  1.14) is
                  inaccessible on any Linux distribution using Kernel
                  6.x or 7.x. The
                  device fails to initialize during the driver probe
                  routine.</span></span></span></font></font></span></p>
    <p
style=3D"line-height: 0.25in; margin-bottom: 0.13in; orphans: 2; widows: 2=
">
      <strong><span style=3D"font-variant: normal"><font
            face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
              style=3D"font-size: 12pt"><span
                style=3D"letter-spacing: normal"><span
                  style=3D"font-style: normal"><b>Symptoms:</b></span></sp=
an></font></font></span></strong></p>
    <ul>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <i>nvidia-smi</i><span style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">=C2=A0fails: "Unable t=
o
                      determine the device handle".</span></span></span></=
font></font></span></p>
      </li>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <i>lspci</i><span style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">=C2=A0shows the device=
 in a
                      broken state:=C2=A0</span></span></span></font></fon=
t></span><i>rev
            ff.</i></p>
      </li>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <i>dmesg</i><span style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">=C2=A0reports:=C2=A0</=
span></span></span></font></font></span><i>Unable
            to change power state from D3cold to D0, device inaccessible.<=
/i></p>
      </li>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <span style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">Crucial Error Log:=C2=
=A0</span></span></span></font></font></span><i>NVRM:
            This is a 64-bit BAR mapped above 4GB by the system BIOS or
            the Linux kernel, but the PCI bridge immediately upstream of
            this GPU does not define a matching prefetchable memory
            window.</i></p>
      </li>
    </ul>
    <p
style=3D"line-height: 0.25in; margin-bottom: 0.13in; orphans: 2; widows: 2=
">
      <strong><span style=3D"font-variant: normal"><font
            face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
              style=3D"font-size: 12pt"><span
                style=3D"letter-spacing: normal"><span
                  style=3D"font-style: normal"><b>Proven
                    Regression Status:</b></span></span></font></font></sp=
an></strong></p>
    <ul>
      <li>
        <p
style=3D"line-height: 0.25in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <strong><span style=3D"font-variant: normal"><font
                face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                  style=3D"font-size: 12pt"><span
                    style=3D"letter-spacing: normal"><span
                      style=3D"font-style: normal"><b>Works:</b></span></s=
pan></font></font></span></strong><span
            style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">=C2=A0Ubuntu 20.04 (Ke=
rnel
                      5.15) and Ubuntu 22.04 (manually downgraded to
                      Kernel 5.15). In this state, the GPU is mapped=C2=A0=
</span></span></span></font></font></span><strong><span
              style=3D"font-variant: normal"><font
                face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                  style=3D"font-size: 12pt"><span
                    style=3D"letter-spacing: normal"><span
                      style=3D"font-style: normal"><b>below the 4GB
                        boundary</b></span></span></font></font></span></s=
trong><span
            style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">, and the driver
                      (v570/v580) works perfectly (glmark2 score ~1300).</=
span></span></span></font></font></span></p>
      </li>
      <li>
        <p
style=3D"line-height: 0.25in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <strong><span style=3D"font-variant: normal"><font
                face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                  style=3D"font-size: 12pt"><span
                    style=3D"letter-spacing: normal"><span
                      style=3D"font-style: normal"><b>Fails:</b></span></s=
pan></font></font></span></strong><span
            style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">=C2=A0Ubuntu 22.04/24.=
04
                      (Kernel 6.5/6.8) and CachyOS (Kernel 6.13/7.0).
                      Any Kernel &gt; 5.15 attempts to map the GPU BARs
                      into the 64-bit address space (&gt; 4GB), which
                      the Acer PCI-bridge fails to handle.=C2=A0</span></s=
pan></span></font></font></span></p>
      </li>
    </ul>
    <p
style=3D"line-height: 0.25in; margin-bottom: 0.13in; orphans: 2; widows: 2=
">
      <strong><span style=3D"font-variant: normal"><font
            face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
              style=3D"font-size: 12pt"><span
                style=3D"letter-spacing: normal"><span
                  style=3D"font-style: normal"><b>Attempted
                    Workarounds (all failed on Kernel 6.x+):</b></span></s=
pan></font></font></span></strong></p>
    <ul>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <i>pci=3Drealloc</i><span style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">=C2=A0(Causes initramf=
s/SSD
                      failure on this hardware).</span></span></span></fon=
t></font></span></p>
      </li>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <i>pci=3Dnocrs,=C2=A0pci=3Dbig_root_window,=C2=A0pci=3Dno64,=C2=
=A0pci=3Drealloc=3Doff.</i></p>
      </li>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <i>acpi_osi=3D"Windows 2015".</i></p>
      </li>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <i>NVreg_EnableGpuFirmware=3D0,=C2=A0NVreg_DynamicPowerManagemen=
t=3D0x02.</i></p>
      </li>
      <li>
        <p
style=3D"letter-spacing: normal; orphans: 2; margin-bottom: 0in; line-heig=
ht: 0.25in; widows: 2; border: none; padding: 0in; font-variant: normal; f=
ont-style: normal; font-weight: normal">
          <font face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
              style=3D"font-size: 12pt">Switching between Wayland and X11
              (No effect).</font></font></p>
      </li>
    </ul>
    <p
style=3D"line-height: 0.25in; margin-bottom: 0.13in; orphans: 2; widows: 2=
"><br>
      <strong><span style=3D"font-variant: normal"><font
            face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
              style=3D"font-size: 12pt"><span
                style=3D"letter-spacing: normal"><span
                  style=3D"font-style: normal"><b>Conclusion:</b></span></=
span></font></font></span></strong><span
        style=3D"font-variant: normal"><font
          face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
            style=3D"font-size: 12pt"><span style=3D"letter-spacing: norma=
l"><span
                style=3D"font-style: normal"><span
                  style=3D"font-weight: normal"><br>
                  This
                  appears to be a PCI resource allocation regression or
                  a missing quirk
                  for the Acer SF314-56G bridge. Newer kernels ignore
                  BIOS limits or
                  fail to correctly negotiate the bridge window for
                  64-bit BARs on this
                  specific motherboard. Currently, the only way to use
                  the GPU is to
                  pin the system to the legacy 5.15 Kernel branch.</span><=
/span></span></font></font></span></p>
    <p
style=3D"line-height: 0.25in; margin-bottom: 0.13in; orphans: 2; widows: 2=
"><br>
      <strong><span style=3D"font-variant: normal"><font
            face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
              style=3D"font-size: 12pt"><span
                style=3D"letter-spacing: normal"><span
                  style=3D"font-style: normal">Additional
                  Findings/New T</span></span></font></font></span></stron=
g><strong><span
          style=3D"font-variant: normal"><font
            face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
              style=3D"font-size: 12pt"><span
                style=3D"letter-spacing: normal"><span
                  style=3D"font-style: normal"><b>est
                    Results:</b></span></span></font></font></span></stron=
g><span
        style=3D"font-variant: normal"><font
          face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
            style=3D"font-size: 12pt"><span style=3D"letter-spacing: norma=
l"><span
                style=3D"font-style: normal"><span
                  style=3D"font-weight: normal"><br>
                  I
                  have further isolated the issue by testing various LTS
                  kernels on the
                  same OS (Ubuntu 22.04) with the same driver (NVIDIA
                  580.142):</span></span></span></font></font></span></p>
    <ul>
      <li>
        <p
style=3D"line-height: 0.25in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <strong><span style=3D"font-variant: normal"><font
                face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                  style=3D"font-size: 12pt"><span
                    style=3D"letter-spacing: normal"><span
                      style=3D"font-style: normal"><b>SUCCESS:</b></span><=
/span></font></font></span></strong><span
            style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">=C2=A0XanMod 5.15.75 L=
TS.
                      GPU initializes perfectly (rev a1), no BAR errors.</=
span></span></span></font></font></span></p>
      </li>
      <li>
        <p
style=3D"line-height: 0.23in; margin-bottom: 0in; orphans: 2; widows: 2; b=
order: none; padding: 0in">
          <strong><span style=3D"font-variant: normal"><font
                face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                  style=3D"font-size: 12pt"><span
                    style=3D"letter-spacing: normal"><span
                      style=3D"font-style: normal"><b>FAIL:</b></span></sp=
an></font></font></span></strong><span
            style=3D"font-variant: normal"><font
              face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
                style=3D"font-size: 12pt"><span
                  style=3D"letter-spacing: normal"><span
                    style=3D"font-style: normal"><span
                      style=3D"font-weight: normal">=C2=A0XanMod 6.1.77 LT=
S.
                      GPU fails with:=C2=A0</span></span></span></font></f=
ont></span><i>pci
            0000:02:00.0: not ready 1023ms after resume; giving up.</i></p=
>
      </li>
    </ul>
    <p
style=3D"line-height: 0.25in; orphans: 2; margin-bottom: 0.13in; widows: 2=
; font-variant: normal; letter-spacing: normal; font-style: normal; font-w=
eight: normal">
      <font face=3D"Google Sans, Arial, sans-serif"><font size=3D"3"
          style=3D"font-size: 12pt">This
          confirms the regression started exactly with the 6.x kernel
          series.
          The 1023ms timeout suggests a race condition or a change in
          how the
          PCI bridge handles the wake-up sequence from D3cold on this
          specific
          Acer hardware.</font></font></p>
    <p>kind regards</p>
  </body>
</html>

--------------SRsI7Sv0YK4GahUUcxwV9vfx--
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu 22-04.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu 22-04.log"
Content-Transfer-Encoding: base64

LS0tIE9TICYgS0VSTkVMIC0tLQpEaXN0cmlidXRvciBJRDoJVWJ1bnR1CkRlc2NyaXB0aW9u
OglVYnVudHUgMjIuMDQuNSBMVFMKUmVsZWFzZToJMjIuMDQKQ29kZW5hbWU6CWphbW15Ckxp
bnV4IGx4dXNlci1Td2lmdC1TRjMxNC01NkcgNi44LjAtMTEwLWdlbmVyaWMgIzExMH4yMi4w
NC4xLVVidW50dSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSBNYXIgMjcgMTI6NDM6MDggVVRD
ICB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgKLS0tIFNFU1NJT04gVFlQRSAtLS0K
d2F5bGFuZAotLS0gSU5TVEFMTEVEIFBBQ0tBR0VTIChOVklESUEvTUVTQSkgLS0tCmlpICBs
aWJkcm0tbm91dmVhdTI6YW1kNjQgICAgICAgICAgICAgICAgICAgICAgMi40LjExMy0yfnVi
dW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBVc2Vy
c3BhY2UgaW50ZXJmYWNlIHRvIG5vdXZlYXUtc3BlY2lmaWMga2VybmVsIERSTSBzZXJ2aWNl
cyAtLSBydW50aW1lCmlpICBsaWJlZ2wtbWVzYTA6YW1kNjQgICAgICAgICAgICAgICAgICAg
ICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAg
IGFtZDY0ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBFR0wgQVBJIC0tIE1l
c2EgdmVuZG9yIGxpYnJhcnkKaWkgIGxpYmdsMS1tZXNhLWRyaTphbWQ2NCAgICAgICAgICAg
ICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAg
ICAgICAgYW1kNjQgICAgICAgIGZyZWUgaW1wbGVtZW50YXRpb24gb2YgdGhlIE9wZW5HTCBB
UEkgLS0gRFJJIG1vZHVsZXMKaWkgIGxpYmdsYXBpLW1lc2E6YW1kNjQgICAgICAgICAgICAg
ICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAg
ICAgICAgYW1kNjQgICAgICAgIGZyZWUgaW1wbGVtZW50YXRpb24gb2YgdGhlIEdMIEFQSSAt
LSBzaGFyZWQgbGlicmFyeQppaSAgbGliZ2x1MS1tZXNhOmFtZDY0ICAgICAgICAgICAgICAg
ICAgICAgICAgIDkuMC4yLTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBhbWQ2NCAgICAgICAgTWVzYSBPcGVuR0wgdXRpbGl0eSBsaWJyYXJ5IChHTFUpCmlp
ICBsaWJnbHgtbWVzYTA6YW1kNjQgICAgICAgICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1
YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBm
cmVlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBPcGVuR0wgQVBJIC0tIEdMWCB2ZW5kb3IgbGli
cmFyeQppaSAgbGlibnZpZGlhLWNmZzEtNTcwOmFtZDY0ICAgICAgICAgICAgICAgICAgIDU3
MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgTlZJRElBIGJpbmFyeSBPcGVuR0wvR0xYIGNvbmZpZ3VyYXRpb24gbGlicmFyeQpp
aSAgbGlibnZpZGlhLWNvbW1vbi01NzAgICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEu
MDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAg
U2hhcmVkIGZpbGVzIHVzZWQgYnkgdGhlIE5WSURJQSBsaWJyYXJpZXMKaWkgIGxpYm52aWRp
YS1jb21wdXRlLTU3MDphbWQ2NCAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUw
LjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBsaWJj
b21wdXRlIHBhY2thZ2UKaWkgIGxpYm52aWRpYS1jb21wdXRlLTU3MDppMzg2ICAgICAgICAg
ICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgaTM4NiAgICAgICAgIE5WSURJQSBsaWJjb21wdXRlIHBhY2thZ2UKaWkgIGxpYm52aWRp
YS1kZWNvZGUtNTcwOmFtZDY0ICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUw
LjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBWaWRl
byBEZWNvZGluZyBydW50aW1lIGxpYnJhcmllcwppaSAgbGlibnZpZGlhLWRlY29kZS01NzA6
aTM4NiAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZJRElBIFZpZGVvIERlY29kaW5nIHJ1
bnRpbWUgbGlicmFyaWVzCmlpICBsaWJudmlkaWEtZWdsLXdheWxhbmQxOmFtZDY0ICAgICAg
ICAgICAgICAgMToxLjEuOS0xLjF1YnVudHUwLjEgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZDY0ICAgICAgICBXYXlsYW5kIEVHTCBFeHRlcm5hbCBQbGF0Zm9ybSBsaWJyYXJ5
IC0tIHNoYXJlZCBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZW5jb2RlLTU3MDphbWQ2NCAgICAg
ICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAg
ICAgICAgIGFtZDY0ICAgICAgICBOVkVOQyBWaWRlbyBFbmNvZGluZyBydW50aW1lIGxpYnJh
cnkKaWkgIGxpYm52aWRpYS1lbmNvZGUtNTcwOmkzODYgICAgICAgICAgICAgICAgICA1NzAu
MjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgaTM4NiAgICAg
ICAgIE5WRU5DIFZpZGVvIEVuY29kaW5nIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZpZGlh
LWV4dHJhLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAu
MjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgRXh0cmEgbGlicmFy
aWVzIGZvciB0aGUgTlZJRElBIGRyaXZlcgppaSAgbGlibnZpZGlhLWZiYzEtNTcwOmFtZDY0
ICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAg
ICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIE9wZW5HTC1iYXNlZCBGcmFtZWJ1
ZmZlciBDYXB0dXJlIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZpZGlhLWZiYzEtNTcwOmkz
ODYgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZJRElBIE9wZW5HTC1iYXNlZCBGcmFt
ZWJ1ZmZlciBDYXB0dXJlIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZpZGlhLWdsLTU3MDph
bWQ2NCAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAg
ICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIE9wZW5HTC9HTFgvRUdM
L0dMRVMgR0xWTkQgbGlicmFyaWVzIGFuZCBWdWxrYW4gSUNECmlpICBtZXNhLXV0aWxzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOC40LjAtMXVidW50dTEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNaXNjZWxsYW5lb3VzIE1l
c2EgdXRpbGl0aWVzIC0tIHN5bWxpbmtzCmlpICBtZXNhLXV0aWxzLWJpbjphbWQ2NCAgICAg
ICAgICAgICAgICAgICAgICAgOC40LjAtMXVidW50dTEgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNaXNjZWxsYW5lb3VzIE1lc2EgdXRpbGl0aWVz
IC0tIG5hdGl2ZSBhcHBsaWNhdGlvbnMKaWkgIG1lc2EtdmRwYXUtZHJpdmVyczphbWQ2NCAg
ICAgICAgICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAg
ICAgICAgICAgICAgYW1kNjQgICAgICAgIE1lc2EgVkRQQVUgdmlkZW8gYWNjZWxlcmF0aW9u
IGRyaXZlcnMKaWkgIG1lc2EtdnVsa2FuLWRyaXZlcnM6YW1kNjQgICAgICAgICAgICAgICAg
ICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAgICAgICAgYW1k
NjQgICAgICAgIE1lc2EgVnVsa2FuIGdyYXBoaWNzIGRyaXZlcnMKaWkgIG52aWRpYS1jb21w
dXRlLXV0aWxzLTU3MCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIy
LjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBjb21wdXRl
IHV0aWxpdGllcwppaSAgbnZpZGlhLWRrbXMtNTcwICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgTlZJRElBIERLTVMgcGFja2FnZQppaSAgbnZpZGlhLWRyaXZlci01NzAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAg
ICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGRyaXZlciBtZXRhcGFj
a2FnZQppaSAgbnZpZGlhLWZpcm13YXJlLTU3MC01NzAuMjExLjAxICAgICAgICAgICAgIDU3
MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgRmlybXdhcmUgZmlsZXMgdXNlZCBieSB0aGUga2VybmVsIG1vZHVsZQppaSAgbnZp
ZGlhLWtlcm5lbC1jb21tb24tNTcwICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVi
dW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgU2hhcmVk
IGZpbGVzIHVzZWQgd2l0aCB0aGUga2VybmVsIG1vZHVsZQppaSAgbnZpZGlhLWtlcm5lbC1z
b3VyY2UtNTcwICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQu
MSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGtlcm5lbCBzb3Vy
Y2UgcGFja2FnZQppaSAgbnZpZGlhLXByaW1lICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDAuOC4xNy4xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
bGwgICAgICAgICAgVG9vbHMgdG8gZW5hYmxlIE5WSURJQSdzIFByaW1lCmlpICBudmlkaWEt
c2V0dGluZ3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTEwLjQ3LjAzLTB1YnVudHUx
LjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBUb29sIGZvciBj
b25maWd1cmluZyB0aGUgTlZJRElBIGdyYXBoaWNzIGRyaXZlcgppaSAgbnZpZGlhLXV0aWxz
LTU3MCAgICAgICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIu
MDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGRyaXZlciBz
dXBwb3J0IGJpbmFyaWVzCmlpICBzY3JlZW4tcmVzb2x1dGlvbi1leHRyYSAgICAgICAgICAg
ICAgICAgICAgMC4xOC4ydWJ1bnR1MC4xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGFsbCAgICAgICAgICBFeHRlbnNpb24gZm9yIHRoZSBudmlkaWEtc2V0dGluZ3MgY29u
dHJvbCBwYW5lbAppaSAgeHNlcnZlci14b3JnLXZpZGVvLW5vdXZlYXUgICAgICAgICAgICAg
ICAgIDE6MS4wLjE3LTJidWlsZDEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgWC5PcmcgWCBzZXJ2ZXIgLS0gTm91dmVhdSBkaXNwbGF5IGRyaXZlcgpp
aSAgeHNlcnZlci14b3JnLXZpZGVvLW52aWRpYS01NzAgICAgICAgICAgICAgIDU3MC4yMTEu
MDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAg
TlZJRElBIGJpbmFyeSBYb3JnIGRyaXZlcgotLS0gUENJIERSSVZFUiBTVEFUVVMgLS0tCjAw
OjAyLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxlcjogSW50ZWwgQ29ycG9yYXRpb24gV2hp
c2tleUxha2UtVSBHVDIgW1VIRCBHcmFwaGljcyA2MjBdCglTdWJzeXN0ZW06IEFjZXIgSW5j
b3Jwb3JhdGVkIFtBTEldIFdoaXNrZXlMYWtlLVUgR1QyIFtVSEQgR3JhcGhpY3MgNjIwXQoJ
S2VybmVsIGRyaXZlciBpbiB1c2U6IGk5MTUKLS0KMDI6MDAuMCAzRCBjb250cm9sbGVyOiBO
VklESUEgQ29ycG9yYXRpb24gR1AxMDhNIFtHZUZvcmNlIE1YMjUwXSAocmV2IGZmKQoJS2Vy
bmVsIG1vZHVsZXM6IG52aWRpYWZiLCBub3V2ZWF1LCBudmlkaWFfZHJtLCBudmlkaWEKMDQ6
MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5IGNvbnRyb2xsZXI6IE1pY3Jvbi9DcnVjaWFsIFRl
Y2hub2xvZ3kgUDEgTlZNZSBQQ0llIFNTRCAocmV2IDAzKQotLS0gR1BVIFJFTkRFUkVSIC0t
LQotLS0gTlZJRElBLVNNSSAtLS0KTlZJRElBLVNNSSBoYXMgZmFpbGVkIGJlY2F1c2UgaXQg
Y291bGRuJ3QgY29tbXVuaWNhdGUgd2l0aCB0aGUgTlZJRElBIGRyaXZlci4gTWFrZSBzdXJl
IHRoYXQgdGhlIGxhdGVzdCBOVklESUEgZHJpdmVyIGlzIGluc3RhbGxlZCBhbmQgcnVubmlu
Zy4KCi0tLSBQT1dFUiBNQU5BR0VNRU5UIC0tLQpDb250cm9sOiBhdXRvClN0YXR1czogc3Vz
cGVuZGVkCi0tLSBMQVNUIDIwIFBDSS9OVklESUEgTE9HUyAtLS0KICAgICAgICAgICAgICAg
TlZSTTogYSBtYXRjaGluZyBwcmVmZXRjaGFibGUgbWVtb3J5IHdpbmRvdy4KWyAzODcwLjI3
OTA4OV0gTlZSTTogVGhpcyBtYXkgYmUgZHVlIHRvIGEga25vd24gTGludXgga2VybmVsIGJ1
Zy4gIFBsZWFzZQogICAgICAgICAgICAgICBOVlJNOiBzZWUgdGhlIFJFQURNRSBzZWN0aW9u
IG9uIDY0LWJpdCBCQVJzIGZvciBhZGRpdGlvbmFsCiAgICAgICAgICAgICAgIE5WUk06IGlu
Zm9ybWF0aW9uLgpbIDM4NzAuMjc5MTQwXSBudmlkaWE6IHByb2JlIG9mIDAwMDA6MDI6MDAu
MCBmYWlsZWQgd2l0aCBlcnJvciAtMQpbIDM4NzAuMjc5MjE1XSBOVlJNOiBUaGUgTlZJRElB
IHByb2JlIHJvdXRpbmUgZmFpbGVkIGZvciAxIGRldmljZShzKS4KWyAzODcwLjI3OTIyMF0g
TlZSTTogTm9uZSBvZiB0aGUgTlZJRElBIGRldmljZXMgd2VyZSBpbml0aWFsaXplZC4KWyAz
ODcwLjI4MDE2MF0gbnZpZGlhLW52bGluazogVW5yZWdpc3RlcmVkIE52bGluayBDb3JlLCBt
YWpvciBkZXZpY2UgbnVtYmVyIDUwOQpbIDM4NzAuODU4OTU5XSBudmlkaWEtbnZsaW5rOiBO
dmxpbmsgQ29yZSBpcyBiZWluZyBpbml0aWFsaXplZCwgbWFqb3IgZGV2aWNlIG51bWJlciA1
MDkKWyAzODcwLjg1ODk2OF0gTlZSTTogVGhpcyBpcyBhIDY0LWJpdCBCQVIgbWFwcGVkIGFi
b3ZlIDRHQiBieSB0aGUgc3lzdGVtCiAgICAgICAgICAgICAgIE5WUk06IEJJT1Mgb3IgdGhl
IExpbnV4IGtlcm5lbCwgYnV0IHRoZSBQQ0kgYnJpZGdlCiAgICAgICAgICAgICAgIE5WUk06
IGltbWVkaWF0ZWx5IHVwc3RyZWFtIG9mIHRoaXMgR1BVIGRvZXMgbm90IGRlZmluZQogICAg
ICAgICAgICAgICBOVlJNOiBhIG1hdGNoaW5nIHByZWZldGNoYWJsZSBtZW1vcnkgd2luZG93
LgpbIDM4NzAuOTk5MDkzXSBOVlJNOiBUaGlzIG1heSBiZSBkdWUgdG8gYSBrbm93biBMaW51
eCBrZXJuZWwgYnVnLiAgUGxlYXNlCiAgICAgICAgICAgICAgIE5WUk06IHNlZSB0aGUgUkVB
RE1FIHNlY3Rpb24gb24gNjQtYml0IEJBUnMgZm9yIGFkZGl0aW9uYWwKICAgICAgICAgICAg
ICAgTlZSTTogaW5mb3JtYXRpb24uClsgMzg3MC45OTkxNDJdIG52aWRpYTogcHJvYmUgb2Yg
MDAwMDowMjowMC4wIGZhaWxlZCB3aXRoIGVycm9yIC0xClsgMzg3MC45OTkyMTJdIE5WUk06
IFRoZSBOVklESUEgcHJvYmUgcm91dGluZSBmYWlsZWQgZm9yIDEgZGV2aWNlKHMpLgpbIDM4
NzAuOTk5MjE1XSBOVlJNOiBOb25lIG9mIHRoZSBOVklESUEgZGV2aWNlcyB3ZXJlIGluaXRp
YWxpemVkLgpbIDM4NzAuOTk5OTI2XSBudmlkaWEtbnZsaW5rOiBVbnJlZ2lzdGVyZWQgTnZs
aW5rIENvcmUsIG1ham9yIGRldmljZSBudW1iZXIgNTA5Cg==
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu
 22-04-32Bit.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu
 22-04-32Bit.log"
Content-Transfer-Encoding: base64

LS0tIE9TICYgS0VSTkVMIC0tLQpCT09UX0lNQUdFPS9ib290L3ZtbGludXotNi44LjAtMTEw
LWdlbmVyaWMgcm9vdD1VVUlEPWU4MmZmYWVjLWY0MGItNGM4Mi04ODY1LTcyZmVhMDU3NWZj
YiBybyBxdWlldCBzcGxhc2ggdnQuaGFuZG9mZj03IHBjaT1yZWFsbG9jPW9mZiBwY2k9MzJi
aXQtcmVzb3VyY2UtbWVtCkRpc3RyaWJ1dG9yIElEOglVYnVudHUKRGVzY3JpcHRpb246CVVi
dW50dSAyMi4wNC41IExUUwpSZWxlYXNlOgkyMi4wNApDb2RlbmFtZToJamFtbXkKTGludXgg
bHh1c2VyLVN3aWZ0LVNGMzE0LTU2RyA2LjguMC0xMTAtZ2VuZXJpYyAjMTEwfjIyLjA0LjEt
VWJ1bnR1IFNNUCBQUkVFTVBUX0RZTkFNSUMgRnJpIE1hciAyNyAxMjo0MzowOCBVVEMgIHg4
Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAotLS0gU0VTU0lPTiBUWVBFIC0tLQp4MTEK
LS0tIElOU1RBTExFRCBQQUNLQUdFUyAoTlZJRElBL01FU0EpIC0tLQppaSAgbGliZHJtLW5v
dXZlYXUyOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgIDIuNC4xMTMtMn51YnVudHUwLjIy
LjA0LjEgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgVXNlcnNwYWNlIGlu
dGVyZmFjZSB0byBub3V2ZWF1LXNwZWNpZmljIGtlcm5lbCBEUk0gc2VydmljZXMgLS0gcnVu
dGltZQppaSAgbGliZWdsLW1lc2EwOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgICAgIDIz
LjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgZnJlZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgRUdMIEFQSSAtLSBNZXNhIHZlbmRv
ciBsaWJyYXJ5CmlpICBsaWJnbDEtbWVzYS1kcmk6YW1kNjQgICAgICAgICAgICAgICAgICAg
ICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFt
ZDY0ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBPcGVuR0wgQVBJIC0tIERS
SSBtb2R1bGVzCmlpICBsaWJnbGFwaS1tZXNhOmFtZDY0ICAgICAgICAgICAgICAgICAgICAg
ICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFt
ZDY0ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBHTCBBUEkgLS0gc2hhcmVk
IGxpYnJhcnkKaWkgIGxpYmdsdTEtbWVzYTphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAg
ICA5LjAuMi0xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1k
NjQgICAgICAgIE1lc2EgT3BlbkdMIHV0aWxpdHkgbGlicmFyeSAoR0xVKQppaSAgbGliZ2x4
LW1lc2EwOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgICAgIDIzLjIuMS0xdWJ1bnR1My4x
fjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgZnJlZSBpbXBs
ZW1lbnRhdGlvbiBvZiB0aGUgT3BlbkdMIEFQSSAtLSBHTFggdmVuZG9yIGxpYnJhcnkKaWkg
IGxpYm52aWRpYS1jZmcxLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAx
LTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5W
SURJQSBiaW5hcnkgT3BlbkdML0dMWCBjb25maWd1cmF0aW9uIGxpYnJhcnkKaWkgIGxpYm52
aWRpYS1jb21tb24tNTcwICAgICAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVu
dHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFNoYXJlZCBm
aWxlcyB1c2VkIGJ5IHRoZSBOVklESUEgbGlicmFyaWVzCmlpICBsaWJudmlkaWEtY29tcHV0
ZS01NzA6YW1kNjQgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4x
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgbGliY29tcHV0ZSBw
YWNrYWdlCmlpICBsaWJudmlkaWEtY29tcHV0ZS01NzA6aTM4NiAgICAgICAgICAgICAgICAg
NTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGkzODYg
ICAgICAgICBOVklESUEgbGliY29tcHV0ZSBwYWNrYWdlCmlpICBsaWJudmlkaWEtZGVjb2Rl
LTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4x
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgVmlkZW8gRGVjb2Rp
bmcgcnVudGltZSBsaWJyYXJpZXMKaWkgIGxpYm52aWRpYS1kZWNvZGUtNTcwOmkzODYgICAg
ICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAg
ICAgICAgICAgaTM4NiAgICAgICAgIE5WSURJQSBWaWRlbyBEZWNvZGluZyBydW50aW1lIGxp
YnJhcmllcwppaSAgbGlibnZpZGlhLWVnbC13YXlsYW5kMTphbWQ2NCAgICAgICAgICAgICAg
IDE6MS4xLjktMS4xdWJ1bnR1MC4xICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2
NCAgICAgICAgV2F5bGFuZCBFR0wgRXh0ZXJuYWwgUGxhdGZvcm0gbGlicmFyeSAtLSBzaGFy
ZWQgbGlicmFyeQppaSAgbGlibnZpZGlhLWVuY29kZS01NzA6YW1kNjQgICAgICAgICAgICAg
ICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgTlZFTkMgVmlkZW8gRW5jb2RpbmcgcnVudGltZSBsaWJyYXJ5CmlpICBs
aWJudmlkaWEtZW5jb2RlLTU3MDppMzg2ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0w
dWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGkzODYgICAgICAgICBOVkVO
QyBWaWRlbyBFbmNvZGluZyBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1leHRyYS01
NzA6YW1kNjQgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEg
ICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIEV4dHJhIGxpYnJhcmllcyBmb3Ig
dGhlIE5WSURJQSBkcml2ZXIKaWkgIGxpYm52aWRpYS1mYmMxLTU3MDphbWQ2NCAgICAgICAg
ICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAg
ICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBPcGVuR0wtYmFzZWQgRnJhbWVidWZmZXIgQ2Fw
dHVyZSBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1mYmMxLTU3MDppMzg2ICAgICAg
ICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAg
ICAgICAgICAgaTM4NiAgICAgICAgIE5WSURJQSBPcGVuR0wtYmFzZWQgRnJhbWVidWZmZXIg
Q2FwdHVyZSBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1nbC01NzA6YW1kNjQgICAg
ICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAg
ICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBPcGVuR0wvR0xYL0VHTC9HTEVTIEdM
Vk5EIGxpYnJhcmllcyBhbmQgVnVsa2FuIElDRAppaSAgbWVzYS11dGlscyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDguNC4wLTF1YnVudHUxICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTWlzY2VsbGFuZW91cyBNZXNhIHV0aWxp
dGllcyAtLSBzeW1saW5rcwppaSAgbWVzYS11dGlscy1iaW46YW1kNjQgICAgICAgICAgICAg
ICAgICAgICAgIDguNC4wLTF1YnVudHUxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBhbWQ2NCAgICAgICAgTWlzY2VsbGFuZW91cyBNZXNhIHV0aWxpdGllcyAtLSBuYXRp
dmUgYXBwbGljYXRpb25zCmlpICBtZXNhLXZkcGF1LWRyaXZlcnM6YW1kNjQgICAgICAgICAg
ICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZDY0ICAgICAgICBNZXNhIFZEUEFVIHZpZGVvIGFjY2VsZXJhdGlvbiBkcml2ZXJz
CmlpICBtZXNhLXZ1bGthbi1kcml2ZXJzOmFtZDY0ICAgICAgICAgICAgICAgICAgMjMuMi4x
LTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAg
ICBNZXNhIFZ1bGthbiBncmFwaGljcyBkcml2ZXJzCmlpICBudmlkaWEtY29tcHV0ZS11dGls
cy01NzAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgY29tcHV0ZSB1dGlsaXRp
ZXMKaWkgIG52aWRpYS1ka21zLTU3MCAgICAgICAgICAgICAgICAgICAgICAgICAgICA1NzAu
MjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAg
ICAgIE5WSURJQSBES01TIHBhY2thZ2UKaWkgIG52aWRpYS1kcml2ZXItNTcwICAgICAgICAg
ICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAg
ICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBkcml2ZXIgbWV0YXBhY2thZ2UKaWkg
IG52aWRpYS1maXJtd2FyZS01NzAtNTcwLjIxMS4wMSAgICAgICAgICAgICA1NzAuMjExLjAx
LTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIEZp
cm13YXJlIGZpbGVzIHVzZWQgYnkgdGhlIGtlcm5lbCBtb2R1bGUKaWkgIG52aWRpYS1rZXJu
ZWwtY29tbW9uLTU3MCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIy
LjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFNoYXJlZCBmaWxlcyB1
c2VkIHdpdGggdGhlIGtlcm5lbCBtb2R1bGUKaWkgIG52aWRpYS1rZXJuZWwtc291cmNlLTU3
MCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAg
ICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBrZXJuZWwgc291cmNlIHBhY2th
Z2UKaWkgIG52aWRpYS1wcmltZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLjgu
MTcuMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWxsICAgICAg
ICAgIFRvb2xzIHRvIGVuYWJsZSBOVklESUEncyBQcmltZQppaSAgbnZpZGlhLXNldHRpbmdz
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUxMC40Ny4wMy0wdWJ1bnR1MS4yMi4wNC4x
ICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgVG9vbCBmb3IgY29uZmlndXJp
bmcgdGhlIE5WSURJQSBncmFwaGljcyBkcml2ZXIKaWkgIG52aWRpYS11dGlscy01NzAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAg
ICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBkcml2ZXIgc3VwcG9ydCBi
aW5hcmllcwppaSAgc2NyZWVuLXJlc29sdXRpb24tZXh0cmEgICAgICAgICAgICAgICAgICAg
IDAuMTguMnVidW50dTAuMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbGwg
ICAgICAgICAgRXh0ZW5zaW9uIGZvciB0aGUgbnZpZGlhLXNldHRpbmdzIGNvbnRyb2wgcGFu
ZWwKaWkgIHhzZXJ2ZXIteG9yZy12aWRlby1ub3V2ZWF1ICAgICAgICAgICAgICAgICAxOjEu
MC4xNy0yYnVpbGQxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAg
ICAgIFguT3JnIFggc2VydmVyIC0tIE5vdXZlYXUgZGlzcGxheSBkcml2ZXIKaWkgIHhzZXJ2
ZXIteG9yZy12aWRlby1udmlkaWEtNTcwICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVu
dHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBi
aW5hcnkgWG9yZyBkcml2ZXIKLS0tIFBDSSBEUklWRVIgU1RBVFVTIC0tLQowMDowMi4wIFZH
QSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIFdoaXNrZXlMYWtl
LVUgR1QyIFtVSEQgR3JhcGhpY3MgNjIwXQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRl
ZCBbQUxJXSBXaGlza2V5TGFrZS1VIEdUMiBbVUhEIEdyYXBoaWNzIDYyMF0KCUtlcm5lbCBk
cml2ZXIgaW4gdXNlOiBpOTE1Ci0tCjAyOjAwLjAgM0QgY29udHJvbGxlcjogTlZJRElBIENv
cnBvcmF0aW9uIEdQMTA4TSBbR2VGb3JjZSBNWDI1MF0gKHJldiBmZikKCUtlcm5lbCBtb2R1
bGVzOiBudmlkaWFmYiwgbm91dmVhdSwgbnZpZGlhX2RybSwgbnZpZGlhCjA0OjAwLjAgTm9u
LVZvbGF0aWxlIG1lbW9yeSBjb250cm9sbGVyOiBNaWNyb24vQ3J1Y2lhbCBUZWNobm9sb2d5
IFAxIE5WTWUgUENJZSBTU0QgKHJldiAwMykKLS0tIEdQVSBSRU5ERVJFUiAtLS0KLS0tIE5W
SURJQS1TTUkgLS0tCk5WSURJQS1TTUkgaGFzIGZhaWxlZCBiZWNhdXNlIGl0IGNvdWxkbid0
IGNvbW11bmljYXRlIHdpdGggdGhlIE5WSURJQSBkcml2ZXIuIE1ha2Ugc3VyZSB0aGF0IHRo
ZSBsYXRlc3QgTlZJRElBIGRyaXZlciBpcyBpbnN0YWxsZWQgYW5kIHJ1bm5pbmcuCgotLS0g
UE9XRVIgTUFOQUdFTUVOVCAtLS0KQ29udHJvbDogYXV0bwpTdGF0dXM6IHN1c3BlbmRlZAot
LS0gTEFTVCAyMCBQQ0kvTlZJRElBIExPR1MgLS0tCiAgICAgICAgICAgICAgIE5WUk06IGEg
bWF0Y2hpbmcgcHJlZmV0Y2hhYmxlIG1lbW9yeSB3aW5kb3cuClsgIDQwOC4zNjgxMDFdIE5W
Uk06IFRoaXMgbWF5IGJlIGR1ZSB0byBhIGtub3duIExpbnV4IGtlcm5lbCBidWcuICBQbGVh
c2UKICAgICAgICAgICAgICAgTlZSTTogc2VlIHRoZSBSRUFETUUgc2VjdGlvbiBvbiA2NC1i
aXQgQkFScyBmb3IgYWRkaXRpb25hbAogICAgICAgICAgICAgICBOVlJNOiBpbmZvcm1hdGlv
bi4KWyAgNDA4LjM2ODE2MF0gbnZpZGlhOiBwcm9iZSBvZiAwMDAwOjAyOjAwLjAgZmFpbGVk
IHdpdGggZXJyb3IgLTEKWyAgNDA4LjM2ODI0OF0gTlZSTTogVGhlIE5WSURJQSBwcm9iZSBy
b3V0aW5lIGZhaWxlZCBmb3IgMSBkZXZpY2UocykuClsgIDQwOC4zNjgyNTRdIE5WUk06IE5v
bmUgb2YgdGhlIE5WSURJQSBkZXZpY2VzIHdlcmUgaW5pdGlhbGl6ZWQuClsgIDQwOC4zNjk2
MzVdIG52aWRpYS1udmxpbms6IFVucmVnaXN0ZXJlZCBOdmxpbmsgQ29yZSwgbWFqb3IgZGV2
aWNlIG51bWJlciA1MDkKWyAgNDA4Ljk2NjIxM10gbnZpZGlhLW52bGluazogTnZsaW5rIENv
cmUgaXMgYmVpbmcgaW5pdGlhbGl6ZWQsIG1ham9yIGRldmljZSBudW1iZXIgNTA5ClsgIDQw
OC45NjYyMjFdIE5WUk06IFRoaXMgaXMgYSA2NC1iaXQgQkFSIG1hcHBlZCBhYm92ZSA0R0Ig
YnkgdGhlIHN5c3RlbQogICAgICAgICAgICAgICBOVlJNOiBCSU9TIG9yIHRoZSBMaW51eCBr
ZXJuZWwsIGJ1dCB0aGUgUENJIGJyaWRnZQogICAgICAgICAgICAgICBOVlJNOiBpbW1lZGlh
dGVseSB1cHN0cmVhbSBvZiB0aGlzIEdQVSBkb2VzIG5vdCBkZWZpbmUKICAgICAgICAgICAg
ICAgTlZSTTogYSBtYXRjaGluZyBwcmVmZXRjaGFibGUgbWVtb3J5IHdpbmRvdy4KWyAgNDA5
LjEwMzY3MF0gTlZSTTogVGhpcyBtYXkgYmUgZHVlIHRvIGEga25vd24gTGludXgga2VybmVs
IGJ1Zy4gIFBsZWFzZQogICAgICAgICAgICAgICBOVlJNOiBzZWUgdGhlIFJFQURNRSBzZWN0
aW9uIG9uIDY0LWJpdCBCQVJzIGZvciBhZGRpdGlvbmFsCiAgICAgICAgICAgICAgIE5WUk06
IGluZm9ybWF0aW9uLgpbICA0MDkuMTAzNzE1XSBudmlkaWE6IHByb2JlIG9mIDAwMDA6MDI6
MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMQpbICA0MDkuMTAzNzY4XSBOVlJNOiBUaGUgTlZJ
RElBIHByb2JlIHJvdXRpbmUgZmFpbGVkIGZvciAxIGRldmljZShzKS4KWyAgNDA5LjEwMzc3
MV0gTlZSTTogTm9uZSBvZiB0aGUgTlZJRElBIGRldmljZXMgd2VyZSBpbml0aWFsaXplZC4K
WyAgNDA5LjEwNDc4Nl0gbnZpZGlhLW52bGluazogVW5yZWdpc3RlcmVkIE52bGluayBDb3Jl
LCBtYWpvciBkZXZpY2UgbnVtYmVyIDUwOQo=
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu
 22-04-bigrootwindow.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu
 22-04-bigrootwindow.log"
Content-Transfer-Encoding: base64

cGNpPWJpZ19yb290X3dpbmRvdwotLS0gT1MgJiBLRVJORUwgLS0tCkRpc3RyaWJ1dG9yIElE
OglVYnVudHUKRGVzY3JpcHRpb246CVVidW50dSAyMi4wNC41IExUUwpSZWxlYXNlOgkyMi4w
NApDb2RlbmFtZToJamFtbXkKTGludXggbHh1c2VyLVN3aWZ0LVNGMzE0LTU2RyA2LjguMC0x
MTAtZ2VuZXJpYyAjMTEwfjIyLjA0LjEtVWJ1bnR1IFNNUCBQUkVFTVBUX0RZTkFNSUMgRnJp
IE1hciAyNyAxMjo0MzowOCBVVEMgIHg4Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAot
LS0gU0VTU0lPTiBUWVBFIC0tLQp4MTEKLS0tIElOU1RBTExFRCBQQUNLQUdFUyAoTlZJRElB
L01FU0EpIC0tLQppaSAgbGliZHJtLW5vdXZlYXUyOmFtZDY0ICAgICAgICAgICAgICAgICAg
ICAgIDIuNC4xMTMtMn51YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgVXNlcnNwYWNlIGludGVyZmFjZSB0byBub3V2ZWF1LXNwZWNpZmljIGtl
cm5lbCBEUk0gc2VydmljZXMgLS0gcnVudGltZQppaSAgbGliZWdsLW1lc2EwOmFtZDY0ICAg
ICAgICAgICAgICAgICAgICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAg
ICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgZnJlZSBpbXBsZW1lbnRhdGlvbiBvZiB0
aGUgRUdMIEFQSSAtLSBNZXNhIHZlbmRvciBsaWJyYXJ5CmlpICBsaWJnbDEtbWVzYS1kcmk6
YW1kNjQgICAgICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAg
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9u
IG9mIHRoZSBPcGVuR0wgQVBJIC0tIERSSSBtb2R1bGVzCmlpICBsaWJnbGFwaS1tZXNhOmFt
ZDY0ICAgICAgICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAg
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9u
IG9mIHRoZSBHTCBBUEkgLS0gc2hhcmVkIGxpYnJhcnkKaWkgIGxpYmdsdTEtbWVzYTphbWQ2
NCAgICAgICAgICAgICAgICAgICAgICAgICA5LjAuMi0xICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE1lc2EgT3BlbkdMIHV0aWxpdHkg
bGlicmFyeSAoR0xVKQppaSAgbGliZ2x4LW1lc2EwOmFtZDY0ICAgICAgICAgICAgICAgICAg
ICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAg
ICBhbWQ2NCAgICAgICAgZnJlZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgT3BlbkdMIEFQSSAt
LSBHTFggdmVuZG9yIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1jZmcxLTU3MDphbWQ2NCAgICAg
ICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAg
ICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBiaW5hcnkgT3BlbkdML0dMWCBjb25maWd1
cmF0aW9uIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1jb21tb24tNTcwICAgICAgICAgICAgICAg
ICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgYW1kNjQgICAgICAgIFNoYXJlZCBmaWxlcyB1c2VkIGJ5IHRoZSBOVklESUEgbGlicmFy
aWVzCmlpICBsaWJudmlkaWEtY29tcHV0ZS01NzA6YW1kNjQgICAgICAgICAgICAgICAgNTcw
LjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAg
ICAgICBOVklESUEgbGliY29tcHV0ZSBwYWNrYWdlCmlpICBsaWJudmlkaWEtY29tcHV0ZS01
NzA6aTM4NiAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgIGkzODYgICAgICAgICBOVklESUEgbGliY29tcHV0ZSBwYWNr
YWdlCmlpICBsaWJudmlkaWEtZGVjb2RlLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgNTcw
LjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAg
ICAgICBOVklESUEgVmlkZW8gRGVjb2RpbmcgcnVudGltZSBsaWJyYXJpZXMKaWkgIGxpYm52
aWRpYS1kZWNvZGUtNTcwOmkzODYgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVu
dHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgaTM4NiAgICAgICAgIE5WSURJQSBW
aWRlbyBEZWNvZGluZyBydW50aW1lIGxpYnJhcmllcwppaSAgbGlibnZpZGlhLWVnbC13YXls
YW5kMTphbWQ2NCAgICAgICAgICAgICAgIDE6MS4xLjktMS4xdWJ1bnR1MC4xICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgV2F5bGFuZCBFR0wgRXh0ZXJuYWwg
UGxhdGZvcm0gbGlicmFyeSAtLSBzaGFyZWQgbGlicmFyeQppaSAgbGlibnZpZGlhLWVuY29k
ZS01NzA6YW1kNjQgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQu
MSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZFTkMgVmlkZW8gRW5jb2Rp
bmcgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZW5jb2RlLTU3MDppMzg2ICAgICAg
ICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAg
ICAgICAgIGkzODYgICAgICAgICBOVkVOQyBWaWRlbyBFbmNvZGluZyBydW50aW1lIGxpYnJh
cnkKaWkgIGxpYm52aWRpYS1leHRyYS01NzA6YW1kNjQgICAgICAgICAgICAgICAgICA1NzAu
MjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAg
ICAgIEV4dHJhIGxpYnJhcmllcyBmb3IgdGhlIE5WSURJQSBkcml2ZXIKaWkgIGxpYm52aWRp
YS1mYmMxLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUw
LjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBPcGVu
R0wtYmFzZWQgRnJhbWVidWZmZXIgQ2FwdHVyZSBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52
aWRpYS1mYmMxLTU3MDppMzg2ICAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVu
dHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgaTM4NiAgICAgICAgIE5WSURJQSBP
cGVuR0wtYmFzZWQgRnJhbWVidWZmZXIgQ2FwdHVyZSBydW50aW1lIGxpYnJhcnkKaWkgIGxp
Ym52aWRpYS1nbC01NzA6YW1kNjQgICAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1
YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJ
QSBPcGVuR0wvR0xYL0VHTC9HTEVTIEdMVk5EIGxpYnJhcmllcyBhbmQgVnVsa2FuIElDRApp
aSAgbWVzYS11dGlscyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDguNC4wLTF1
YnVudHUxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAg
TWlzY2VsbGFuZW91cyBNZXNhIHV0aWxpdGllcyAtLSBzeW1saW5rcwppaSAgbWVzYS11dGls
cy1iaW46YW1kNjQgICAgICAgICAgICAgICAgICAgICAgIDguNC4wLTF1YnVudHUxICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTWlzY2VsbGFuZW91
cyBNZXNhIHV0aWxpdGllcyAtLSBuYXRpdmUgYXBwbGljYXRpb25zCmlpICBtZXNhLXZkcGF1
LWRyaXZlcnM6YW1kNjQgICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIu
MDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNZXNhIFZEUEFVIHZp
ZGVvIGFjY2VsZXJhdGlvbiBkcml2ZXJzCmlpICBtZXNhLXZ1bGthbi1kcml2ZXJzOmFtZDY0
ICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAg
ICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNZXNhIFZ1bGthbiBncmFwaGljcyBkcml2ZXJz
CmlpICBudmlkaWEtY29tcHV0ZS11dGlscy01NzAgICAgICAgICAgICAgICAgICAgNTcwLjIx
MS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAg
ICBOVklESUEgY29tcHV0ZSB1dGlsaXRpZXMKaWkgIG52aWRpYS1ka21zLTU3MCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAg
ICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBES01TIHBhY2thZ2UKaWkgIG52
aWRpYS1kcml2ZXItNTcwICAgICAgICAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1
YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJ
QSBkcml2ZXIgbWV0YXBhY2thZ2UKaWkgIG52aWRpYS1maXJtd2FyZS01NzAtNTcwLjIxMS4w
MSAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAg
ICAgICAgICAgYW1kNjQgICAgICAgIEZpcm13YXJlIGZpbGVzIHVzZWQgYnkgdGhlIGtlcm5l
bCBtb2R1bGUKaWkgIG52aWRpYS1rZXJuZWwtY29tbW9uLTU3MCAgICAgICAgICAgICAgICAg
ICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1k
NjQgICAgICAgIFNoYXJlZCBmaWxlcyB1c2VkIHdpdGggdGhlIGtlcm5lbCBtb2R1bGUKaWkg
IG52aWRpYS1rZXJuZWwtc291cmNlLTU3MCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAx
LTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5W
SURJQSBrZXJuZWwgc291cmNlIHBhY2thZ2UKaWkgIG52aWRpYS1wcmltZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAwLjguMTcuMSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYWxsICAgICAgICAgIFRvb2xzIHRvIGVuYWJsZSBOVklESUEncyBQ
cmltZQppaSAgbnZpZGlhLXNldHRpbmdzICAgICAgICAgICAgICAgICAgICAgICAgICAgIDUx
MC40Ny4wMy0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgVG9vbCBmb3IgY29uZmlndXJpbmcgdGhlIE5WSURJQSBncmFwaGljcyBkcml2ZXIK
aWkgIG52aWRpYS11dGlscy01NzAgICAgICAgICAgICAgICAgICAgICAgICAgICA1NzAuMjEx
LjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAg
IE5WSURJQSBkcml2ZXIgc3VwcG9ydCBiaW5hcmllcwppaSAgc2NyZWVuLXJlc29sdXRpb24t
ZXh0cmEgICAgICAgICAgICAgICAgICAgIDAuMTguMnVidW50dTAuMSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhbGwgICAgICAgICAgRXh0ZW5zaW9uIGZvciB0aGUgbnZp
ZGlhLXNldHRpbmdzIGNvbnRyb2wgcGFuZWwKaWkgIHhzZXJ2ZXIteG9yZy12aWRlby1ub3V2
ZWF1ICAgICAgICAgICAgICAgICAxOjEuMC4xNy0yYnVpbGQxICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFguT3JnIFggc2VydmVyIC0tIE5vdXZlYXUg
ZGlzcGxheSBkcml2ZXIKaWkgIHhzZXJ2ZXIteG9yZy12aWRlby1udmlkaWEtNTcwICAgICAg
ICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgYW1kNjQgICAgICAgIE5WSURJQSBiaW5hcnkgWG9yZyBkcml2ZXIKLS0tIFBDSSBEUklW
RVIgU1RBVFVTIC0tLQowMDowMi4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEludGVs
IENvcnBvcmF0aW9uIFdoaXNrZXlMYWtlLVUgR1QyIFtVSEQgR3JhcGhpY3MgNjIwXQoJU3Vi
c3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBXaGlza2V5TGFrZS1VIEdUMiBbVUhE
IEdyYXBoaWNzIDYyMF0KCUtlcm5lbCBkcml2ZXIgaW4gdXNlOiBpOTE1Ci0tCjAyOjAwLjAg
M0QgY29udHJvbGxlcjogTlZJRElBIENvcnBvcmF0aW9uIEdQMTA4TSBbR2VGb3JjZSBNWDI1
MF0gKHJldiBmZikKCUtlcm5lbCBtb2R1bGVzOiBudmlkaWFmYiwgbm91dmVhdSwgbnZpZGlh
X2RybSwgbnZpZGlhCjA0OjAwLjAgTm9uLVZvbGF0aWxlIG1lbW9yeSBjb250cm9sbGVyOiBN
aWNyb24vQ3J1Y2lhbCBUZWNobm9sb2d5IFAxIE5WTWUgUENJZSBTU0QgKHJldiAwMykKLS0t
IEdQVSBSRU5ERVJFUiAtLS0KLS0tIE5WSURJQS1TTUkgLS0tCk5WSURJQS1TTUkgaGFzIGZh
aWxlZCBiZWNhdXNlIGl0IGNvdWxkbid0IGNvbW11bmljYXRlIHdpdGggdGhlIE5WSURJQSBk
cml2ZXIuIE1ha2Ugc3VyZSB0aGF0IHRoZSBsYXRlc3QgTlZJRElBIGRyaXZlciBpcyBpbnN0
YWxsZWQgYW5kIHJ1bm5pbmcuCgotLS0gUE9XRVIgTUFOQUdFTUVOVCAtLS0KQ29udHJvbDog
YXV0bwpTdGF0dXM6IHN1c3BlbmRlZAotLS0gTEFTVCAyMCBQQ0kvTlZJRElBIExPR1MgLS0t
CiAgICAgICAgICAgICAgIE5WUk06IGEgbWF0Y2hpbmcgcHJlZmV0Y2hhYmxlIG1lbW9yeSB3
aW5kb3cuClsgIDQ4OC43MjEwMTZdIE5WUk06IFRoaXMgbWF5IGJlIGR1ZSB0byBhIGtub3du
IExpbnV4IGtlcm5lbCBidWcuICBQbGVhc2UKICAgICAgICAgICAgICAgTlZSTTogc2VlIHRo
ZSBSRUFETUUgc2VjdGlvbiBvbiA2NC1iaXQgQkFScyBmb3IgYWRkaXRpb25hbAogICAgICAg
ICAgICAgICBOVlJNOiBpbmZvcm1hdGlvbi4KWyAgNDg4LjcyMTA3OV0gbnZpZGlhOiBwcm9i
ZSBvZiAwMDAwOjAyOjAwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTEKWyAgNDg4LjcyMTE0NF0g
TlZSTTogVGhlIE5WSURJQSBwcm9iZSByb3V0aW5lIGZhaWxlZCBmb3IgMSBkZXZpY2Uocyku
ClsgIDQ4OC43MjExNDhdIE5WUk06IE5vbmUgb2YgdGhlIE5WSURJQSBkZXZpY2VzIHdlcmUg
aW5pdGlhbGl6ZWQuClsgIDQ4OC43MjIzOTldIG52aWRpYS1udmxpbms6IFVucmVnaXN0ZXJl
ZCBOdmxpbmsgQ29yZSwgbWFqb3IgZGV2aWNlIG51bWJlciA1MDkKWyAgNDg5LjI2MDIzMl0g
bnZpZGlhLW52bGluazogTnZsaW5rIENvcmUgaXMgYmVpbmcgaW5pdGlhbGl6ZWQsIG1ham9y
IGRldmljZSBudW1iZXIgNTA5ClsgIDQ4OS4yNjAyNDFdIE5WUk06IFRoaXMgaXMgYSA2NC1i
aXQgQkFSIG1hcHBlZCBhYm92ZSA0R0IgYnkgdGhlIHN5c3RlbQogICAgICAgICAgICAgICBO
VlJNOiBCSU9TIG9yIHRoZSBMaW51eCBrZXJuZWwsIGJ1dCB0aGUgUENJIGJyaWRnZQogICAg
ICAgICAgICAgICBOVlJNOiBpbW1lZGlhdGVseSB1cHN0cmVhbSBvZiB0aGlzIEdQVSBkb2Vz
IG5vdCBkZWZpbmUKICAgICAgICAgICAgICAgTlZSTTogYSBtYXRjaGluZyBwcmVmZXRjaGFi
bGUgbWVtb3J5IHdpbmRvdy4KWyAgNDg5LjQwMTAzOV0gTlZSTTogVGhpcyBtYXkgYmUgZHVl
IHRvIGEga25vd24gTGludXgga2VybmVsIGJ1Zy4gIFBsZWFzZQogICAgICAgICAgICAgICBO
VlJNOiBzZWUgdGhlIFJFQURNRSBzZWN0aW9uIG9uIDY0LWJpdCBCQVJzIGZvciBhZGRpdGlv
bmFsCiAgICAgICAgICAgICAgIE5WUk06IGluZm9ybWF0aW9uLgpbICA0ODkuNDAxMDg3XSBu
dmlkaWE6IHByb2JlIG9mIDAwMDA6MDI6MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMQpbICA0
ODkuNDAxMTUyXSBOVlJNOiBUaGUgTlZJRElBIHByb2JlIHJvdXRpbmUgZmFpbGVkIGZvciAx
IGRldmljZShzKS4KWyAgNDg5LjQwMTE1NF0gTlZSTTogTm9uZSBvZiB0aGUgTlZJRElBIGRl
dmljZXMgd2VyZSBpbml0aWFsaXplZC4KWyAgNDg5LjQwMTY0M10gbnZpZGlhLW52bGluazog
VW5yZWdpc3RlcmVkIE52bGluayBDb3JlLCBtYWpvciBkZXZpY2UgbnVtYmVyIDUwOQo=
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu
 22-04-Kernel5.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu
 22-04-Kernel5.log"
Content-Transfer-Encoding: base64

LS0tIE9TICYgS0VSTkVMIC0tLQpCT09UX0lNQUdFPS9ib290L3ZtbGludXotNS4xNS4wLTE3
Ni1nZW5lcmljIHJvb3Q9VVVJRD1lODJmZmFlYy1mNDBiLTRjODItODg2NS03MmZlYTA1NzVm
Y2Igcm8gcXVpZXQgc3BsYXNoIHZ0LmhhbmRvZmY9NwpEaXN0cmlidXRvciBJRDoJVWJ1bnR1
CkRlc2NyaXB0aW9uOglVYnVudHUgMjIuMDQuNSBMVFMKUmVsZWFzZToJMjIuMDQKQ29kZW5h
bWU6CWphbW15CkxpbnV4IGx4dXNlci1Td2lmdC1TRjMxNC01NkcgNS4xNS4wLTE3Ni1nZW5l
cmljICMxODYtVWJ1bnR1IFNNUCBGcmkgTWFyIDEzIDExOjAxOjQyIFVUQyAyMDI2IHg4Nl82
NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAotLS0gU0VTU0lPTiBUWVBFIC0tLQp4MTEKLS0t
IElOU1RBTExFRCBQQUNLQUdFUyAoTlZJRElBL01FU0EpIC0tLQppaSAgbGliZHJtLW5vdXZl
YXUyOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgIDIuNC4xMTMtMn51YnVudHUwLjIyLjA0
LjEgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgVXNlcnNwYWNlIGludGVy
ZmFjZSB0byBub3V2ZWF1LXNwZWNpZmljIGtlcm5lbCBEUk0gc2VydmljZXMgLS0gcnVudGlt
ZQppaSAgbGliZWdsLW1lc2EwOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgICAgIDIzLjIu
MS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAg
ICAgZnJlZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgRUdMIEFQSSAtLSBNZXNhIHZlbmRvciBs
aWJyYXJ5CmlpICBsaWJnbDEtbWVzYS1kcmk6YW1kNjQgICAgICAgICAgICAgICAgICAgICAg
MjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBPcGVuR0wgQVBJIC0tIERSSSBt
b2R1bGVzCmlpICBsaWJnbGFwaS1tZXNhOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgICAg
MjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBHTCBBUEkgLS0gc2hhcmVkIGxp
YnJhcnkKaWkgIGxpYmdsdTEtbWVzYTphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAgICA5
LjAuMi0xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQg
ICAgICAgIE1lc2EgT3BlbkdMIHV0aWxpdHkgbGlicmFyeSAoR0xVKQppaSAgbGliZ2x4LW1l
c2EwOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIy
LjA0LjMgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgZnJlZSBpbXBsZW1l
bnRhdGlvbiBvZiB0aGUgT3BlbkdMIEFQSSAtLSBHTFggdmVuZG9yIGxpYnJhcnkKaWkgIGxp
Ym52aWRpYS1jZmcxLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1
YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJ
QSBiaW5hcnkgT3BlbkdML0dMWCBjb25maWd1cmF0aW9uIGxpYnJhcnkKaWkgIGxpYm52aWRp
YS1jb21tb24tNTcwICAgICAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUw
LjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFNoYXJlZCBmaWxl
cyB1c2VkIGJ5IHRoZSBOVklESUEgbGlicmFyaWVzCmlpICBsaWJudmlkaWEtY29tcHV0ZS01
NzA6YW1kNjQgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgbGliY29tcHV0ZSBwYWNr
YWdlCmlpICBsaWJudmlkaWEtY29tcHV0ZS01NzA6aTM4NiAgICAgICAgICAgICAgICAgNTcw
LjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGkzODYgICAg
ICAgICBOVklESUEgbGliY29tcHV0ZSBwYWNrYWdlCmlpICBsaWJudmlkaWEtZGVjb2RlLTU3
MDphbWQ2NCAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgVmlkZW8gRGVjb2Rpbmcg
cnVudGltZSBsaWJyYXJpZXMKaWkgIGxpYm52aWRpYS1kZWNvZGUtNTcwOmkzODYgICAgICAg
ICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAg
ICAgICAgaTM4NiAgICAgICAgIE5WSURJQSBWaWRlbyBEZWNvZGluZyBydW50aW1lIGxpYnJh
cmllcwppaSAgbGlibnZpZGlhLWVnbC13YXlsYW5kMTphbWQ2NCAgICAgICAgICAgICAgIDE6
MS4xLjktMS4xdWJ1bnR1MC4xICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgV2F5bGFuZCBFR0wgRXh0ZXJuYWwgUGxhdGZvcm0gbGlicmFyeSAtLSBzaGFyZWQg
bGlicmFyeQppaSAgbGlibnZpZGlhLWVuY29kZS01NzA6YW1kNjQgICAgICAgICAgICAgICAg
IDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2
NCAgICAgICAgTlZFTkMgVmlkZW8gRW5jb2RpbmcgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJu
dmlkaWEtZW5jb2RlLTU3MDppMzg2ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1
bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGkzODYgICAgICAgICBOVkVOQyBW
aWRlbyBFbmNvZGluZyBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1leHRyYS01NzA6
YW1kNjQgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAg
ICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIEV4dHJhIGxpYnJhcmllcyBmb3IgdGhl
IE5WSURJQSBkcml2ZXIKaWkgIGxpYm52aWRpYS1mYmMxLTU3MDphbWQ2NCAgICAgICAgICAg
ICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgYW1kNjQgICAgICAgIE5WSURJQSBPcGVuR0wtYmFzZWQgRnJhbWVidWZmZXIgQ2FwdHVy
ZSBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1mYmMxLTU3MDppMzg2ICAgICAgICAg
ICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAg
ICAgICAgaTM4NiAgICAgICAgIE5WSURJQSBPcGVuR0wtYmFzZWQgRnJhbWVidWZmZXIgQ2Fw
dHVyZSBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1nbC01NzA6YW1kNjQgICAgICAg
ICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAg
ICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBPcGVuR0wvR0xYL0VHTC9HTEVTIEdMVk5E
IGxpYnJhcmllcyBhbmQgVnVsa2FuIElDRAppaSAgbWVzYS11dGlscyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIDguNC4wLTF1YnVudHUxICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTWlzY2VsbGFuZW91cyBNZXNhIHV0aWxpdGll
cyAtLSBzeW1saW5rcwppaSAgbWVzYS11dGlscy1iaW46YW1kNjQgICAgICAgICAgICAgICAg
ICAgICAgIDguNC4wLTF1YnVudHUxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhbWQ2NCAgICAgICAgTWlzY2VsbGFuZW91cyBNZXNhIHV0aWxpdGllcyAtLSBuYXRpdmUg
YXBwbGljYXRpb25zCmlpICBtZXNhLXZkcGF1LWRyaXZlcnM6YW1kNjQgICAgICAgICAgICAg
ICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAg
IGFtZDY0ICAgICAgICBNZXNhIFZEUEFVIHZpZGVvIGFjY2VsZXJhdGlvbiBkcml2ZXJzCmlp
ICBtZXNhLXZ1bGthbi1kcml2ZXJzOmFtZDY0ICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1
YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBN
ZXNhIFZ1bGthbiBncmFwaGljcyBkcml2ZXJzCmlpICBudmlkaWEtY29tcHV0ZS11dGlscy01
NzAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAg
ICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgY29tcHV0ZSB1dGlsaXRpZXMK
aWkgIG52aWRpYS1ka21zLTU3MCAgICAgICAgICAgICAgICAgICAgICAgICAgICA1NzAuMjEx
LjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAg
IE5WSURJQSBES01TIHBhY2thZ2UKaWkgIG52aWRpYS1kcml2ZXItNTcwICAgICAgICAgICAg
ICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAg
ICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBkcml2ZXIgbWV0YXBhY2thZ2UKaWkgIG52
aWRpYS1maXJtd2FyZS01NzAtNTcwLjIxMS4wMSAgICAgICAgICAgICA1NzAuMjExLjAxLTB1
YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIEZpcm13
YXJlIGZpbGVzIHVzZWQgYnkgdGhlIGtlcm5lbCBtb2R1bGUKaWkgIG52aWRpYS1rZXJuZWwt
Y29tbW9uLTU3MCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0
LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFNoYXJlZCBmaWxlcyB1c2Vk
IHdpdGggdGhlIGtlcm5lbCBtb2R1bGUKaWkgIG52aWRpYS1rZXJuZWwtc291cmNlLTU3MCAg
ICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAg
ICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBrZXJuZWwgc291cmNlIHBhY2thZ2UK
aWkgIG52aWRpYS1wcmltZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwLjguMTcu
MSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWxsICAgICAgICAg
IFRvb2xzIHRvIGVuYWJsZSBOVklESUEncyBQcmltZQppaSAgbnZpZGlhLXNldHRpbmdzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIDUxMC40Ny4wMy0wdWJ1bnR1MS4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgVG9vbCBmb3IgY29uZmlndXJpbmcg
dGhlIE5WSURJQSBncmFwaGljcyBkcml2ZXIKaWkgIG52aWRpYS11dGlscy01NzAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAg
ICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBkcml2ZXIgc3VwcG9ydCBiaW5h
cmllcwppaSAgc2NyZWVuLXJlc29sdXRpb24tZXh0cmEgICAgICAgICAgICAgICAgICAgIDAu
MTguMnVidW50dTAuMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbGwgICAg
ICAgICAgRXh0ZW5zaW9uIGZvciB0aGUgbnZpZGlhLXNldHRpbmdzIGNvbnRyb2wgcGFuZWwK
aWkgIHhzZXJ2ZXIteG9yZy12aWRlby1ub3V2ZWF1ICAgICAgICAgICAgICAgICAxOjEuMC4x
Ny0yYnVpbGQxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAg
IFguT3JnIFggc2VydmVyIC0tIE5vdXZlYXUgZGlzcGxheSBkcml2ZXIKaWkgIHhzZXJ2ZXIt
eG9yZy12aWRlby1udmlkaWEtNTcwICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUw
LjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBiaW5h
cnkgWG9yZyBkcml2ZXIKLS0tIFBDSSBEUklWRVIgU1RBVFVTIC0tLQowMDowMi4wIFZHQSBj
b21wYXRpYmxlIGNvbnRyb2xsZXI6IEludGVsIENvcnBvcmF0aW9uIFdoaXNrZXlMYWtlLVUg
R1QyIFtVSEQgR3JhcGhpY3MgNjIwXQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBb
QUxJXSBXaGlza2V5TGFrZS1VIEdUMiBbVUhEIEdyYXBoaWNzIDYyMF0KCUtlcm5lbCBkcml2
ZXIgaW4gdXNlOiBpOTE1Ci0tCjAyOjAwLjAgM0QgY29udHJvbGxlcjogTlZJRElBIENvcnBv
cmF0aW9uIEdQMTA4TSBbR2VGb3JjZSBNWDI1MF0gKHJldiBhMSkKCVN1YnN5c3RlbTogQWNl
ciBJbmNvcnBvcmF0ZWQgW0FMSV0gR1AxMDhNIFtHZUZvcmNlIE1YMjUwXQoJS2VybmVsIGRy
aXZlciBpbiB1c2U6IG52aWRpYQotLS0gR1BVIFJFTkRFUkVSIC0tLQpPcGVuR0wgcmVuZGVy
ZXIgc3RyaW5nOiBOVklESUEgR2VGb3JjZSBNWDI1MC9QQ0llL1NTRTIKLS0tIE5WSURJQS1T
TUkgLS0tClR1ZSBBcHIgMjggMTA6MzA6MTcgMjAyNiAgICAgICAKKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tKwp8IE5WSURJQS1TTUkgNTcwLjIxMS4wMSAgICAgICAg
ICAgICBEcml2ZXIgVmVyc2lvbjogNTcwLjIxMS4wMSAgICAgQ1VEQSBWZXJzaW9uOiAxMi44
ICAgICB8CnwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKfCBHUFUgIE5h
bWUgICAgICAgICAgICAgICAgIFBlcnNpc3RlbmNlLU0gfCBCdXMtSWQgICAgICAgICAgRGlz
cC5BIHwgVm9sYXRpbGUgVW5jb3JyLiBFQ0MgfAp8IEZhbiAgVGVtcCAgIFBlcmYgICAgICAg
ICAgUHdyOlVzYWdlL0NhcCB8ICAgICAgICAgICBNZW1vcnktVXNhZ2UgfCBHUFUtVXRpbCAg
Q29tcHV0ZSBNLiB8CnwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgTUlHIE0uIHwKfD09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Kz09PT09PT09PT09PT09
PT09PT09PT09PSs9PT09PT09PT09PT09PT09PT09PT09fAp8ICAgMCAgTlZJRElBIEdlRm9y
Y2UgTVgyNTAgICAgICAgICAgIE9mZiB8ICAgMDAwMDAwMDA6MDI6MDAuMCBPZmYgfCAgICAg
ICAgICAgICAgICAgIE4vQSB8CnwgTi9BICAgNDFDICAgIFAwICAgICAgICAgICAgTi9BICAv
IDUwMDFXIHwgICAgICAgNU1pQiAvICAgMjA0OE1pQiB8ICAgICAgMCUgICAgICBEZWZhdWx0
IHwKfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICBOL0EgfAorLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKfCBQcm9jZXNz
ZXM6ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfAp8ICBHUFUgICBHSSAgIENJICAgICAgICAg
ICAgICBQSUQgICBUeXBlICAgUHJvY2VzcyBuYW1lICAgICAgICAgICAgICAgICAgICAgICAg
R1BVIE1lbW9yeSB8CnwgICAgICAgIElEICAgSUQgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBVc2FnZSAgICAgIHwKfD09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09fAp8ICAgIDAgICBOL0EgIE4vQSAg
ICAgICAgICAgIDE4MTUgICAgICBHICAgL3Vzci9saWIveG9yZy9Yb3JnICAgICAgICAgICAg
ICAgICAgICAgICAgNE1pQiB8CistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LSsKLS0tIFBPV0VSIE1BTkFHRU1FTlQgLS0tCkNvbnRyb2w6IGF1dG8KU3RhdHVzOiBhY3Rp
dmUKLS0tIExBU1QgMjAgUENJL05WSURJQSBMT0dTIC0tLQpbICAgIDAuNjA4OTczXSBwY2kg
MDAwMDowMjowMC4wOiByZWcgMHgxNDogW21lbSAweDkwMDAwMDAwLTB4OWZmZmZmZmYgNjRi
aXQgcHJlZl0KWyAgICAwLjYwODk4MF0gcGNpIDAwMDA6MDI6MDAuMDogcmVnIDB4MWM6IFtt
ZW0gMHhhMDAwMDAwMC0weGExZmZmZmZmIDY0Yml0IHByZWZdClsgICAgMC42MDg5ODVdIHBj
aSAwMDAwOjAyOjAwLjA6IHJlZyAweDI0OiBbaW8gIDB4MzAwMC0weDMwN2ZdClsgICAgMC42
MDg5OTBdIHBjaSAwMDAwOjAyOjAwLjA6IHJlZyAweDMwOiBbbWVtIDB4ZmZmODAwMDAtMHhm
ZmZmZmZmZiBwcmVmXQpbICAgIDAuNjA5MDI3XSBwY2kgMDAwMDowMjowMC4wOiBFbmFibGlu
ZyBIREEgY29udHJvbGxlcgpbICAgIDAuNzQ0NDExXSBwY2kgMDAwMDowMjowMC4wOiBjYW4n
dCBjbGFpbSBCQVIgNiBbbWVtIDB4ZmZmODAwMDAtMHhmZmZmZmZmZiBwcmVmXTogbm8gY29t
cGF0aWJsZSBicmlkZ2Ugd2luZG93ClsgICAgMC43NDQ3NjZdIHBjaSAwMDAwOjAyOjAwLjA6
IEJBUiA2OiBubyBzcGFjZSBmb3IgW21lbSBzaXplIDB4MDAwODAwMDAgcHJlZl0KWyAgICAw
Ljc0NDc2OV0gcGNpIDAwMDA6MDI6MDAuMDogQkFSIDY6IGZhaWxlZCB0byBhc3NpZ24gW21l
bSBzaXplIDB4MDAwODAwMDAgcHJlZl0KWyAgIDUzLjA0NTY0MF0gYXVkaXQ6IHR5cGU9MTQw
MCBhdWRpdCgxNzc3MzY0NzM1LjczODoyKTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0aW9u
PSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Im52aWRpYV9tb2Rw
cm9iZSIgcGlkPTY4MyBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICA1My4wNDU2NDRdIGF1
ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc3NzM2NDczNS43Mzg6Myk6IGFwcGFybW9yPSJTVEFU
VVMiIG9wZXJhdGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1l
PSJudmlkaWFfbW9kcHJvYmUvL2ttb2QiIHBpZD02ODMgY29tbT0iYXBwYXJtb3JfcGFyc2Vy
IgpbICAgNjguMjI5MTc3XSBudmlkaWE6IGxvYWRpbmcgb3V0LW9mLXRyZWUgbW9kdWxlIHRh
aW50cyBrZXJuZWwuClsgICA2OC4yMjkxODddIG52aWRpYTogbW9kdWxlIGxpY2Vuc2UgJ05W
SURJQScgdGFpbnRzIGtlcm5lbC4KWyAgIDY4LjI0ODg2OF0gbnZpZGlhOiBtb2R1bGUgdmVy
aWZpY2F0aW9uIGZhaWxlZDogc2lnbmF0dXJlIGFuZC9vciByZXF1aXJlZCBrZXkgbWlzc2lu
ZyAtIHRhaW50aW5nIGtlcm5lbApbICAgNjguMjcwNTAxXSBudmlkaWEtbnZsaW5rOiBOdmxp
bmsgQ29yZSBpcyBiZWluZyBpbml0aWFsaXplZCwgbWFqb3IgZGV2aWNlIG51bWJlciA1MDgK
WyAgIDY4LjI3MTczN10gbnZpZGlhIDAwMDA6MDI6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgw
MTA2IC0+IDAxMDcpClsgICA2OC4zODc2ODNdIE5WUk06IGxvYWRpbmcgTlZJRElBIFVOSVgg
eDg2XzY0IEtlcm5lbCBNb2R1bGUgIDU3MC4yMTEuMDEgIFR1ZSBOb3YgMjUgMTY6MzY6MzYg
VVRDIDIwMjUKWyAgIDY5LjAwMzMwN10gbnZpZGlhLW1vZGVzZXQ6IExvYWRpbmcgTlZJRElB
IEtlcm5lbCBNb2RlIFNldHRpbmcgRHJpdmVyIGZvciBVTklYIHBsYXRmb3JtcyAgNTcwLjIx
MS4wMSAgVHVlIE5vdiAyNSAxNjoxMTozOSBVVEMgMjAyNQpbICAgNjkuMDgwNzkyXSBbZHJt
XSBbbnZpZGlhLWRybV0gW0dQVSBJRCAweDAwMDAwMjAwXSBMb2FkaW5nIGRyaXZlcgpbICAg
NjkuNDc2NTkzXSBbZHJtXSBJbml0aWFsaXplZCBudmlkaWEtZHJtIDAuMC4wIDIwMTYwMjAy
IGZvciAwMDAwOjAyOjAwLjAgb24gbWlub3IgMQpbICAgNzAuNDIzNzI4XSBudmlkaWFfdXZt
OiBtb2R1bGUgdXNlcyBzeW1ib2xzIGZyb20gcHJvcHJpZXRhcnkgbW9kdWxlIG52aWRpYSwg
aW5oZXJpdGluZyB0YWludC4K
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu
 22-04-Kernel5-wayland.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu
 22-04-Kernel5-wayland.log"
Content-Transfer-Encoding: base64

LS0tIE9TICYgS0VSTkVMIC0tLQpCT09UX0lNQUdFPS9ib290L3ZtbGludXotNS4xNS4wLTE3
Ni1nZW5lcmljIHJvb3Q9VVVJRD1lODJmZmFlYy1mNDBiLTRjODItODg2NS03MmZlYTA1NzVm
Y2Igcm8gcXVpZXQgc3BsYXNoIHZ0LmhhbmRvZmY9NwpEaXN0cmlidXRvciBJRDoJVWJ1bnR1
CkRlc2NyaXB0aW9uOglVYnVudHUgMjIuMDQuNSBMVFMKUmVsZWFzZToJMjIuMDQKQ29kZW5h
bWU6CWphbW15CkxpbnV4IGx4dXNlci1Td2lmdC1TRjMxNC01NkcgNS4xNS4wLTE3Ni1nZW5l
cmljICMxODYtVWJ1bnR1IFNNUCBGcmkgTWFyIDEzIDExOjAxOjQyIFVUQyAyMDI2IHg4Nl82
NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAotLS0gU0VTU0lPTiBUWVBFIC0tLQp3YXlsYW5k
Ci0tLSBJTlNUQUxMRUQgUEFDS0FHRVMgKE5WSURJQS9NRVNBKSAtLS0KaWkgIGxpYmRybS1u
b3V2ZWF1MjphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAyLjQuMTEzLTJ+dWJ1bnR1MC4y
Mi4wNC4xICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFVzZXJzcGFjZSBp
bnRlcmZhY2UgdG8gbm91dmVhdS1zcGVjaWZpYyBrZXJuZWwgRFJNIHNlcnZpY2VzIC0tIHJ1
bnRpbWUKaWkgIGxpYmVnbC1tZXNhMDphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAgICAy
My4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQg
ICAgICAgIGZyZWUgaW1wbGVtZW50YXRpb24gb2YgdGhlIEVHTCBBUEkgLS0gTWVzYSB2ZW5k
b3IgbGlicmFyeQppaSAgbGliZ2wxLW1lc2EtZHJpOmFtZDY0ICAgICAgICAgICAgICAgICAg
ICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgZnJlZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgT3BlbkdMIEFQSSAtLSBE
UkkgbW9kdWxlcwppaSAgbGliZ2xhcGktbWVzYTphbWQ2NCAgICAgICAgICAgICAgICAgICAg
ICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgZnJlZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgR0wgQVBJIC0tIHNoYXJl
ZCBsaWJyYXJ5CmlpICBsaWJnbHUxLW1lc2E6YW1kNjQgICAgICAgICAgICAgICAgICAgICAg
ICAgOS4wLjItMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFt
ZDY0ICAgICAgICBNZXNhIE9wZW5HTCB1dGlsaXR5IGxpYnJhcnkgKEdMVSkKaWkgIGxpYmds
eC1tZXNhMDphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAgICAyMy4yLjEtMXVidW50dTMu
MX4yMi4wNC4zICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIGZyZWUgaW1w
bGVtZW50YXRpb24gb2YgdGhlIE9wZW5HTCBBUEkgLS0gR0xYIHZlbmRvciBsaWJyYXJ5Cmlp
ICBsaWJudmlkaWEtY2ZnMS01NzA6YW1kNjQgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4w
MS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBO
VklESUEgYmluYXJ5IE9wZW5HTC9HTFggY29uZmlndXJhdGlvbiBsaWJyYXJ5CmlpICBsaWJu
dmlkaWEtY29tbW9uLTU3MCAgICAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1
bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBTaGFyZWQg
ZmlsZXMgdXNlZCBieSB0aGUgTlZJRElBIGxpYnJhcmllcwppaSAgbGlibnZpZGlhLWNvbXB1
dGUtNTcwOmFtZDY0ICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQu
MSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGxpYmNvbXB1dGUg
cGFja2FnZQppaSAgbGlibnZpZGlhLWNvbXB1dGUtNTcwOmkzODYgICAgICAgICAgICAgICAg
IDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBpMzg2
ICAgICAgICAgTlZJRElBIGxpYmNvbXB1dGUgcGFja2FnZQppaSAgbGlibnZpZGlhLWRlY29k
ZS01NzA6YW1kNjQgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQu
MSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIFZpZGVvIERlY29k
aW5nIHJ1bnRpbWUgbGlicmFyaWVzCmlpICBsaWJudmlkaWEtZGVjb2RlLTU3MDppMzg2ICAg
ICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAg
ICAgICAgICAgIGkzODYgICAgICAgICBOVklESUEgVmlkZW8gRGVjb2RpbmcgcnVudGltZSBs
aWJyYXJpZXMKaWkgIGxpYm52aWRpYS1lZ2wtd2F5bGFuZDE6YW1kNjQgICAgICAgICAgICAg
ICAxOjEuMS45LTEuMXVidW50dTAuMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYW1k
NjQgICAgICAgIFdheWxhbmQgRUdMIEV4dGVybmFsIFBsYXRmb3JtIGxpYnJhcnkgLS0gc2hh
cmVkIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1lbmNvZGUtNTcwOmFtZDY0ICAgICAgICAgICAg
ICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAg
YW1kNjQgICAgICAgIE5WRU5DIFZpZGVvIEVuY29kaW5nIHJ1bnRpbWUgbGlicmFyeQppaSAg
bGlibnZpZGlhLWVuY29kZS01NzA6aTM4NiAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEt
MHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZF
TkMgVmlkZW8gRW5jb2RpbmcgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZXh0cmEt
NTcwOmFtZDY0ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4x
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBFeHRyYSBsaWJyYXJpZXMgZm9y
IHRoZSBOVklESUEgZHJpdmVyCmlpICBsaWJudmlkaWEtZmJjMS01NzA6YW1kNjQgICAgICAg
ICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAg
ICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgT3BlbkdMLWJhc2VkIEZyYW1lYnVmZmVyIENh
cHR1cmUgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZmJjMS01NzA6aTM4NiAgICAg
ICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAg
ICAgICAgICAgIGkzODYgICAgICAgICBOVklESUEgT3BlbkdMLWJhc2VkIEZyYW1lYnVmZmVy
IENhcHR1cmUgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZ2wtNTcwOmFtZDY0ICAg
ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAg
ICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgT3BlbkdML0dMWC9FR0wvR0xFUyBH
TFZORCBsaWJyYXJpZXMgYW5kIFZ1bGthbiBJQ0QKaWkgIG1lc2EtdXRpbHMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICA4LjQuMC0xdWJ1bnR1MSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE1pc2NlbGxhbmVvdXMgTWVzYSB1dGls
aXRpZXMgLS0gc3ltbGlua3MKaWkgIG1lc2EtdXRpbHMtYmluOmFtZDY0ICAgICAgICAgICAg
ICAgICAgICAgICA4LjQuMC0xdWJ1bnR1MSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYW1kNjQgICAgICAgIE1pc2NlbGxhbmVvdXMgTWVzYSB1dGlsaXRpZXMgLS0gbmF0
aXZlIGFwcGxpY2F0aW9ucwppaSAgbWVzYS12ZHBhdS1kcml2ZXJzOmFtZDY0ICAgICAgICAg
ICAgICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAg
ICAgICBhbWQ2NCAgICAgICAgTWVzYSBWRFBBVSB2aWRlbyBhY2NlbGVyYXRpb24gZHJpdmVy
cwppaSAgbWVzYS12dWxrYW4tZHJpdmVyczphbWQ2NCAgICAgICAgICAgICAgICAgIDIzLjIu
MS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAg
ICAgTWVzYSBWdWxrYW4gZ3JhcGhpY3MgZHJpdmVycwppaSAgbnZpZGlhLWNvbXB1dGUtdXRp
bHMtNTcwICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAg
ICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGNvbXB1dGUgdXRpbGl0
aWVzCmlpICBudmlkaWEtZGttcy01NzAgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTcw
LjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAg
ICAgICBOVklESUEgREtNUyBwYWNrYWdlCmlpICBudmlkaWEtZHJpdmVyLTU3MCAgICAgICAg
ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAg
ICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgZHJpdmVyIG1ldGFwYWNrYWdlCmlp
ICBudmlkaWEtZmlybXdhcmUtNTcwLTU3MC4yMTEuMDEgICAgICAgICAgICAgNTcwLjIxMS4w
MS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBG
aXJtd2FyZSBmaWxlcyB1c2VkIGJ5IHRoZSBrZXJuZWwgbW9kdWxlCmlpICBudmlkaWEta2Vy
bmVsLWNvbW1vbi01NzAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4y
Mi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBTaGFyZWQgZmlsZXMg
dXNlZCB3aXRoIHRoZSBrZXJuZWwgbW9kdWxlCmlpICBudmlkaWEta2VybmVsLXNvdXJjZS01
NzAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAg
ICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEga2VybmVsIHNvdXJjZSBwYWNr
YWdlCmlpICBudmlkaWEtcHJpbWUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMC44
LjE3LjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFsbCAgICAg
ICAgICBUb29scyB0byBlbmFibGUgTlZJRElBJ3MgUHJpbWUKaWkgIG52aWRpYS1zZXR0aW5n
cyAgICAgICAgICAgICAgICAgICAgICAgICAgICA1MTAuNDcuMDMtMHVidW50dTEuMjIuMDQu
MSAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFRvb2wgZm9yIGNvbmZpZ3Vy
aW5nIHRoZSBOVklESUEgZ3JhcGhpY3MgZHJpdmVyCmlpICBudmlkaWEtdXRpbHMtNTcwICAg
ICAgICAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgZHJpdmVyIHN1cHBvcnQg
YmluYXJpZXMKaWkgIHNjcmVlbi1yZXNvbHV0aW9uLWV4dHJhICAgICAgICAgICAgICAgICAg
ICAwLjE4LjJ1YnVudHUwLjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWxs
ICAgICAgICAgIEV4dGVuc2lvbiBmb3IgdGhlIG52aWRpYS1zZXR0aW5ncyBjb250cm9sIHBh
bmVsCmlpICB4c2VydmVyLXhvcmctdmlkZW8tbm91dmVhdSAgICAgICAgICAgICAgICAgMTox
LjAuMTctMmJ1aWxkMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAg
ICAgICBYLk9yZyBYIHNlcnZlciAtLSBOb3V2ZWF1IGRpc3BsYXkgZHJpdmVyCmlpICB4c2Vy
dmVyLXhvcmctdmlkZW8tbnZpZGlhLTU3MCAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1
bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEg
YmluYXJ5IFhvcmcgZHJpdmVyCi0tLSBQQ0kgRFJJVkVSIFNUQVRVUyAtLS0KMDA6MDIuMCBW
R0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBXaGlza2V5TGFr
ZS1VIEdUMiBbVUhEIEdyYXBoaWNzIDYyMF0KCVN1YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0
ZWQgW0FMSV0gV2hpc2tleUxha2UtVSBHVDIgW1VIRCBHcmFwaGljcyA2MjBdCglLZXJuZWwg
ZHJpdmVyIGluIHVzZTogaTkxNQotLQowMjowMC4wIDNEIGNvbnRyb2xsZXI6IE5WSURJQSBD
b3Jwb3JhdGlvbiBHUDEwOE0gW0dlRm9yY2UgTVgyNTBdIChyZXYgYTEpCglTdWJzeXN0ZW06
IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIEdQMTA4TSBbR2VGb3JjZSBNWDI1MF0KCUtlcm5l
bCBkcml2ZXIgaW4gdXNlOiBudmlkaWEKLS0tIEdQVSBSRU5ERVJFUiAtLS0KT3BlbkdMIHJl
bmRlcmVyIHN0cmluZzogTlZJRElBIEdlRm9yY2UgTVgyNTAvUENJZS9TU0UyCi0tLSBOVklE
SUEtU01JIC0tLQpUdWUgQXByIDI4IDEwOjM2OjU2IDIwMjYgICAgICAgCistLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKfCBOVklESUEtU01JIDU3MC4yMTEuMDEgICAg
ICAgICAgICAgRHJpdmVyIFZlcnNpb246IDU3MC4yMTEuMDEgICAgIENVREEgVmVyc2lvbjog
MTIuOCAgICAgfAp8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0r
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCnwgR1BV
ICBOYW1lICAgICAgICAgICAgICAgICBQZXJzaXN0ZW5jZS1NIHwgQnVzLUlkICAgICAgICAg
IERpc3AuQSB8IFZvbGF0aWxlIFVuY29yci4gRUNDIHwKfCBGYW4gIFRlbXAgICBQZXJmICAg
ICAgICAgIFB3cjpVc2FnZS9DYXAgfCAgICAgICAgICAgTWVtb3J5LVVzYWdlIHwgR1BVLVV0
aWwgIENvbXB1dGUgTS4gfAp8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIE1JRyBNLiB8
Cnw9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PSs9PT09PT09PT09
PT09PT09PT09PT09PT0rPT09PT09PT09PT09PT09PT09PT09PXwKfCAgIDAgIE5WSURJQSBH
ZUZvcmNlIE1YMjUwICAgICAgICAgICBPZmYgfCAgIDAwMDAwMDAwOjAyOjAwLjAgT2ZmIHwg
ICAgICAgICAgICAgICAgICBOL0EgfAp8IE4vQSAgIDQ5QyAgICBQMCAgICAgICAgICAgIE4v
QSAgLyA1MDAxVyB8ICAgICAgIDJNaUIgLyAgIDIwNDhNaUIgfCAgICAgIDAlICAgICAgRGVm
YXVsdCB8CnwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgTi9BIHwKKy0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIAorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCnwgUHJv
Y2Vzc2VzOiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwKfCAgR1BVICAgR0kgICBDSSAgICAg
ICAgICAgICAgUElEICAgVHlwZSAgIFByb2Nlc3MgbmFtZSAgICAgICAgICAgICAgICAgICAg
ICAgIEdQVSBNZW1vcnkgfAp8ICAgICAgICBJRCAgIElEICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVXNhZ2UgICAgICB8
Cnw9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PXwKfCAgICAwICAgTi9BICBO
L0EgICAgICAgICAgICA1MjgwICAgICAgRyAgIC91c3IvYmluL2dub21lLXNoZWxsICAgICAg
ICAgICAgICAgICAgICAgIDBNaUIgfAorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0rCi0tLSBQT1dFUiBNQU5BR0VNRU5UIC0tLQpDb250cm9sOiBhdXRvClN0YXR1czog
YWN0aXZlCi0tLSBMQVNUIDIwIFBDSS9OVklESUEgTE9HUyAtLS0KWyAgICAwLjYwODk3M10g
cGNpIDAwMDA6MDI6MDAuMDogcmVnIDB4MTQ6IFttZW0gMHg5MDAwMDAwMC0weDlmZmZmZmZm
IDY0Yml0IHByZWZdClsgICAgMC42MDg5ODBdIHBjaSAwMDAwOjAyOjAwLjA6IHJlZyAweDFj
OiBbbWVtIDB4YTAwMDAwMDAtMHhhMWZmZmZmZiA2NGJpdCBwcmVmXQpbICAgIDAuNjA4OTg1
XSBwY2kgMDAwMDowMjowMC4wOiByZWcgMHgyNDogW2lvICAweDMwMDAtMHgzMDdmXQpbICAg
IDAuNjA4OTkwXSBwY2kgMDAwMDowMjowMC4wOiByZWcgMHgzMDogW21lbSAweGZmZjgwMDAw
LTB4ZmZmZmZmZmYgcHJlZl0KWyAgICAwLjYwOTAyN10gcGNpIDAwMDA6MDI6MDAuMDogRW5h
YmxpbmcgSERBIGNvbnRyb2xsZXIKWyAgICAwLjc0NDQxMV0gcGNpIDAwMDA6MDI6MDAuMDog
Y2FuJ3QgY2xhaW0gQkFSIDYgW21lbSAweGZmZjgwMDAwLTB4ZmZmZmZmZmYgcHJlZl06IG5v
IGNvbXBhdGlibGUgYnJpZGdlIHdpbmRvdwpbICAgIDAuNzQ0NzY2XSBwY2kgMDAwMDowMjow
MC4wOiBCQVIgNjogbm8gc3BhY2UgZm9yIFttZW0gc2l6ZSAweDAwMDgwMDAwIHByZWZdClsg
ICAgMC43NDQ3NjldIHBjaSAwMDAwOjAyOjAwLjA6IEJBUiA2OiBmYWlsZWQgdG8gYXNzaWdu
IFttZW0gc2l6ZSAweDAwMDgwMDAwIHByZWZdClsgICA1My4wNDU2NDBdIGF1ZGl0OiB0eXBl
PTE0MDAgYXVkaXQoMTc3NzM2NDczNS43Mzg6Mik6IGFwcGFybW9yPSJTVEFUVVMiIG9wZXJh
dGlvbj0icHJvZmlsZV9sb2FkIiBwcm9maWxlPSJ1bmNvbmZpbmVkIiBuYW1lPSJudmlkaWFf
bW9kcHJvYmUiIHBpZD02ODMgY29tbT0iYXBwYXJtb3JfcGFyc2VyIgpbICAgNTMuMDQ1NjQ0
XSBhdWRpdDogdHlwZT0xNDAwIGF1ZGl0KDE3NzczNjQ3MzUuNzM4OjMpOiBhcHBhcm1vcj0i
U1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIg
bmFtZT0ibnZpZGlhX21vZHByb2JlLy9rbW9kIiBwaWQ9NjgzIGNvbW09ImFwcGFybW9yX3Bh
cnNlciIKWyAgIDY4LjIyOTE3N10gbnZpZGlhOiBsb2FkaW5nIG91dC1vZi10cmVlIG1vZHVs
ZSB0YWludHMga2VybmVsLgpbICAgNjguMjI5MTg3XSBudmlkaWE6IG1vZHVsZSBsaWNlbnNl
ICdOVklESUEnIHRhaW50cyBrZXJuZWwuClsgICA2OC4yNDg4NjhdIG52aWRpYTogbW9kdWxl
IHZlcmlmaWNhdGlvbiBmYWlsZWQ6IHNpZ25hdHVyZSBhbmQvb3IgcmVxdWlyZWQga2V5IG1p
c3NpbmcgLSB0YWludGluZyBrZXJuZWwKWyAgIDY4LjI3MDUwMV0gbnZpZGlhLW52bGluazog
TnZsaW5rIENvcmUgaXMgYmVpbmcgaW5pdGlhbGl6ZWQsIG1ham9yIGRldmljZSBudW1iZXIg
NTA4ClsgICA2OC4yNzE3MzddIG52aWRpYSAwMDAwOjAyOjAwLjA6IGVuYWJsaW5nIGRldmlj
ZSAoMDEwNiAtPiAwMTA3KQpbICAgNjguMzg3NjgzXSBOVlJNOiBsb2FkaW5nIE5WSURJQSBV
TklYIHg4Nl82NCBLZXJuZWwgTW9kdWxlICA1NzAuMjExLjAxICBUdWUgTm92IDI1IDE2OjM2
OjM2IFVUQyAyMDI1ClsgICA2OS4wMDMzMDddIG52aWRpYS1tb2Rlc2V0OiBMb2FkaW5nIE5W
SURJQSBLZXJuZWwgTW9kZSBTZXR0aW5nIERyaXZlciBmb3IgVU5JWCBwbGF0Zm9ybXMgIDU3
MC4yMTEuMDEgIFR1ZSBOb3YgMjUgMTY6MTE6MzkgVVRDIDIwMjUKWyAgIDY5LjA4MDc5Ml0g
W2RybV0gW252aWRpYS1kcm1dIFtHUFUgSUQgMHgwMDAwMDIwMF0gTG9hZGluZyBkcml2ZXIK
WyAgIDY5LjQ3NjU5M10gW2RybV0gSW5pdGlhbGl6ZWQgbnZpZGlhLWRybSAwLjAuMCAyMDE2
MDIwMiBmb3IgMDAwMDowMjowMC4wIG9uIG1pbm9yIDEKWyAgIDcwLjQyMzcyOF0gbnZpZGlh
X3V2bTogbW9kdWxlIHVzZXMgc3ltYm9scyBmcm9tIHByb3ByaWV0YXJ5IG1vZHVsZSBudmlk
aWEsIGluaGVyaXRpbmcgdGFpbnQuCg==
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu
 22-04-Kernel6.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu
 22-04-Kernel6.log"
Content-Transfer-Encoding: base64

LS0tIE9TICYgS0VSTkVMIC0tLQpCT09UX0lNQUdFPS9ib290L3ZtbGludXotNi44LjAtMTEw
LWdlbmVyaWMgcm9vdD1VVUlEPWU4MmZmYWVjLWY0MGItNGM4Mi04ODY1LTcyZmVhMDU3NWZj
YiBybyBxdWlldCBzcGxhc2ggdnQuaGFuZG9mZj03IHBjaT1yZWFsbG9jPW9mZiBwY2k9bm82
NApEaXN0cmlidXRvciBJRDoJVWJ1bnR1CkRlc2NyaXB0aW9uOglVYnVudHUgMjIuMDQuNSBM
VFMKUmVsZWFzZToJMjIuMDQKQ29kZW5hbWU6CWphbW15CkxpbnV4IGx4dXNlci1Td2lmdC1T
RjMxNC01NkcgNi44LjAtMTEwLWdlbmVyaWMgIzExMH4yMi4wNC4xLVVidW50dSBTTVAgUFJF
RU1QVF9EWU5BTUlDIEZyaSBNYXIgMjcgMTI6NDM6MDggVVRDICB4ODZfNjQgeDg2XzY0IHg4
Nl82NCBHTlUvTGludXgKLS0tIFNFU1NJT04gVFlQRSAtLS0Kd2F5bGFuZAotLS0gSU5TVEFM
TEVEIFBBQ0tBR0VTIChOVklESUEvTUVTQSkgLS0tCmlpICBsaWJkcm0tbm91dmVhdTI6YW1k
NjQgICAgICAgICAgICAgICAgICAgICAgMi40LjExMy0yfnVidW50dTAuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBVc2Vyc3BhY2UgaW50ZXJmYWNlIHRv
IG5vdXZlYXUtc3BlY2lmaWMga2VybmVsIERSTSBzZXJ2aWNlcyAtLSBydW50aW1lCmlpICBs
aWJlZ2wtbWVzYTA6YW1kNjQgICAgICAgICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVu
dHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBmcmVl
IGltcGxlbWVudGF0aW9uIG9mIHRoZSBFR0wgQVBJIC0tIE1lc2EgdmVuZG9yIGxpYnJhcnkK
aWkgIGxpYmdsMS1tZXNhLWRyaTphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAyMy4yLjEt
MXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAg
IGZyZWUgaW1wbGVtZW50YXRpb24gb2YgdGhlIE9wZW5HTCBBUEkgLS0gRFJJIG1vZHVsZXMK
aWkgIGxpYmdsYXBpLW1lc2E6YW1kNjQgICAgICAgICAgICAgICAgICAgICAgICAyMy4yLjEt
MXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAg
IGZyZWUgaW1wbGVtZW50YXRpb24gb2YgdGhlIEdMIEFQSSAtLSBzaGFyZWQgbGlicmFyeQpp
aSAgbGliZ2x1MS1tZXNhOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgICAgIDkuMC4yLTEg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAg
TWVzYSBPcGVuR0wgdXRpbGl0eSBsaWJyYXJ5IChHTFUpCmlpICBsaWJnbHgtbWVzYTA6YW1k
NjQgICAgICAgICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAg
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9u
IG9mIHRoZSBPcGVuR0wgQVBJIC0tIEdMWCB2ZW5kb3IgbGlicmFyeQppaSAgbGlibnZpZGlh
LWNmZzEtNTcwOmFtZDY0ICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEu
MjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGJpbmFy
eSBPcGVuR0wvR0xYIGNvbmZpZ3VyYXRpb24gbGlicmFyeQppaSAgbGlibnZpZGlhLWNmZzEt
NTgwOmFtZDY0ICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAg
ICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGJpbmFyeSBPcGVu
R0wvR0xYIGNvbmZpZ3VyYXRpb24gbGlicmFyeQppaSAgbGlibnZpZGlhLWNvbW1vbi01NzAg
ICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICBhbGwgICAgICAgICAgU2hhcmVkIGZpbGVzIHVzZWQgYnkgdGhl
IE5WSURJQSBsaWJyYXJpZXMKaWkgIGxpYm52aWRpYS1jb21tb24tNTgwICAgICAgICAgICAg
ICAgICAgICAgICA1ODAuMTQyLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgICAgYWxsICAgICAgICAgIFNoYXJlZCBmaWxlcyB1c2VkIGJ5IHRoZSBOVklESUEgbGli
cmFyaWVzCmlpICBsaWJudmlkaWEtY29tcHV0ZS01NzA6YW1kNjQgICAgICAgICAgICAgICAg
NTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBOVklESUEgbGliY29tcHV0ZSBwYWNrYWdlCmlpICBsaWJudmlkaWEtY29tcHV0
ZS01NzA6aTM4NiAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4x
ICAgICAgICAgICAgICAgICAgICAgIGkzODYgICAgICAgICBOVklESUEgbGliY29tcHV0ZSBw
YWNrYWdlCmlpICBsaWJudmlkaWEtY29tcHV0ZS01ODA6YW1kNjQgICAgICAgICAgICAgICAg
NTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBOVklESUEgbGliY29tcHV0ZSBwYWNrYWdlCmlpICBsaWJudmlkaWEtY29tcHV0
ZS01ODA6aTM4NiAgICAgICAgICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgICAgIGkzODYgICAgICAgICBOVklESUEgbGliY29tcHV0ZSBw
YWNrYWdlCmlpICBsaWJudmlkaWEtZGVjb2RlLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAg
NTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBOVklESUEgVmlkZW8gRGVjb2RpbmcgcnVudGltZSBsaWJyYXJpZXMKaWkgIGxp
Ym52aWRpYS1kZWNvZGUtNTcwOmkzODYgICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1
YnVudHUxLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgaTM4NiAgICAgICAgIE5WSURJ
QSBWaWRlbyBEZWNvZGluZyBydW50aW1lIGxpYnJhcmllcwppaSAgbGlibnZpZGlhLWRlY29k
ZS01ODA6YW1kNjQgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAg
ICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIFZpZGVvIERlY29k
aW5nIHJ1bnRpbWUgbGlicmFyaWVzCmlpICBsaWJudmlkaWEtZGVjb2RlLTU4MDppMzg2ICAg
ICAgICAgICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAg
ICAgICAgICAgIGkzODYgICAgICAgICBOVklESUEgVmlkZW8gRGVjb2RpbmcgcnVudGltZSBs
aWJyYXJpZXMKaWkgIGxpYm52aWRpYS1lZ2wtd2F5bGFuZDE6YW1kNjQgICAgICAgICAgICAg
ICAxOjEuMS4xNy0wdWJ1bnR1MH5ncHUyMi4wNC4xICAgICAgICAgICAgICAgICAgICAgYW1k
NjQgICAgICAgIFdheWxhbmQgRUdMIEV4dGVybmFsIFBsYXRmb3JtIGxpYnJhcnkgLS0gc2hh
cmVkIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1lZ2wtd2F5bGFuZDE6aTM4NiAgICAgICAgICAg
ICAgICAxOjEuMS4xNy0wdWJ1bnR1MH5ncHUyMi4wNC4xICAgICAgICAgICAgICAgICAgICAg
aTM4NiAgICAgICAgIFdheWxhbmQgRUdMIEV4dGVybmFsIFBsYXRmb3JtIGxpYnJhcnkgLS0g
c2hhcmVkIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1lbmNvZGUtNTcwOmFtZDY0ICAgICAgICAg
ICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUxLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgYW1kNjQgICAgICAgIE5WRU5DIFZpZGVvIEVuY29kaW5nIHJ1bnRpbWUgbGlicmFyeQpp
aSAgbGlibnZpZGlhLWVuY29kZS01NzA6aTM4NiAgICAgICAgICAgICAgICAgIDU3MC4yMTEu
MDEtMHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAg
TlZFTkMgVmlkZW8gRW5jb2RpbmcgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZW5j
b2RlLTU4MDphbWQ2NCAgICAgICAgICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4x
ICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVkVOQyBWaWRlbyBFbmNv
ZGluZyBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1lbmNvZGUtNTgwOmkzODYgICAg
ICAgICAgICAgICAgICA1ODAuMTQyLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAg
ICAgICAgICAgaTM4NiAgICAgICAgIE5WRU5DIFZpZGVvIEVuY29kaW5nIHJ1bnRpbWUgbGli
cmFyeQppaSAgbGlibnZpZGlhLWV4dHJhLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgIDU3
MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgRXh0cmEgbGlicmFyaWVzIGZvciB0aGUgTlZJRElBIGRyaXZlcgppaSAgbGlibnZp
ZGlhLWV4dHJhLTU4MDphbWQ2NCAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAu
MjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgRXh0cmEgbGli
cmFyaWVzIGZvciB0aGUgTlZJRElBIGRyaXZlcgppaSAgbGlibnZpZGlhLWZiYzEtNTcwOmFt
ZDY0ICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIE9wZW5HTC1iYXNlZCBGcmFt
ZWJ1ZmZlciBDYXB0dXJlIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZpZGlhLWZiYzEtNTcw
OmkzODYgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAg
ICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZJRElBIE9wZW5HTC1iYXNlZCBG
cmFtZWJ1ZmZlciBDYXB0dXJlIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZpZGlhLWZiYzEt
NTgwOmFtZDY0ICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAg
ICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIE9wZW5HTC1iYXNl
ZCBGcmFtZWJ1ZmZlciBDYXB0dXJlIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZpZGlhLWZi
YzEtNTgwOmkzODYgICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQu
MSAgICAgICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZJRElBIE9wZW5HTC1i
YXNlZCBGcmFtZWJ1ZmZlciBDYXB0dXJlIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZpZGlh
LWdsLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEu
MjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIE9wZW5H
TC9HTFgvRUdML0dMRVMgR0xWTkQgbGlicmFyaWVzIGFuZCBWdWxrYW4gSUNECmlpICBsaWJu
dmlkaWEtZ2wtNTgwOmFtZDY0ICAgICAgICAgICAgICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1
MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEg
T3BlbkdML0dMWC9FR0wvR0xFUyBHTFZORCBsaWJyYXJpZXMgYW5kIFZ1bGthbiBJQ0QKaWkg
IGxpYm52aWRpYS1nbC01ODA6aTM4NiAgICAgICAgICAgICAgICAgICAgICA1ODAuMTQyLTB1
YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgICAgaTM4NiAgICAgICAgIE5W
SURJQSBPcGVuR0wvR0xYL0VHTC9HTEVTIEdMVk5EIGxpYnJhcmllcyBhbmQgVnVsa2FuIElD
RAppaSAgbWVzYS11dGlscyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDguNC4w
LTF1YnVudHUxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAg
ICAgTWlzY2VsbGFuZW91cyBNZXNhIHV0aWxpdGllcyAtLSBzeW1saW5rcwppaSAgbWVzYS11
dGlscy1iaW46YW1kNjQgICAgICAgICAgICAgICAgICAgICAgIDguNC4wLTF1YnVudHUxICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTWlzY2VsbGFu
ZW91cyBNZXNhIHV0aWxpdGllcyAtLSBuYXRpdmUgYXBwbGljYXRpb25zCmlpICBtZXNhLXZk
cGF1LWRyaXZlcnM6YW1kNjQgICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+
MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNZXNhIFZEUEFV
IHZpZGVvIGFjY2VsZXJhdGlvbiBkcml2ZXJzCmlpICBtZXNhLXZ1bGthbi1kcml2ZXJzOmFt
ZDY0ICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAg
ICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNZXNhIFZ1bGthbiBncmFwaGljcyBkcml2
ZXJzCmlpICBudmlkaWEtY29tcHV0ZS11dGlscy01NzAgICAgICAgICAgICAgICAgICAgNTcw
LjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAg
ICAgICBOVklESUEgY29tcHV0ZSB1dGlsaXRpZXMKaWkgIG52aWRpYS1jb21wdXRlLXV0aWxz
LTU4MCAgICAgICAgICAgICAgICAgICA1ODAuMTQyLTB1YnVudHUwLjIyLjA0LjEgICAgICAg
ICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBjb21wdXRlIHV0aWxpdGll
cwppaSAgbnZpZGlhLWRrbXMtNTcwICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU3MC4y
MTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAg
ICAgTlZJRElBIERLTVMgcGFja2FnZQppaSAgbnZpZGlhLWRrbXMtNTgwICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAg
ICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIERLTVMgcGFja2FnZQppaSAgbnZpZGlh
LWRyaXZlci01NzAgICAgICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50
dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGRy
aXZlciBtZXRhcGFja2FnZQppaSAgbnZpZGlhLWRyaXZlci01ODAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAg
ICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGRyaXZlciBtZXRhcGFja2FnZQppaSAgbnZpZGlh
LWZpcm13YXJlLTU3MC01NzAuMjExLjAxICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50
dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgRmlybXdhcmUg
ZmlsZXMgdXNlZCBieSB0aGUga2VybmVsIG1vZHVsZQppaSAgbnZpZGlhLWZpcm13YXJlLTU4
MC01ODAuMTQyICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgRmlybXdhcmUgZmlsZXMgdXNlZCBi
eSB0aGUga2VybmVsIG1vZHVsZQppaSAgbnZpZGlhLWtlcm5lbC1jb21tb24tNTcwICAgICAg
ICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAg
ICAgICAgICBhbWQ2NCAgICAgICAgU2hhcmVkIGZpbGVzIHVzZWQgd2l0aCB0aGUga2VybmVs
IG1vZHVsZQppaSAgbnZpZGlhLWtlcm5lbC1jb21tb24tNTgwICAgICAgICAgICAgICAgICAg
IDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2
NCAgICAgICAgU2hhcmVkIGZpbGVzIHVzZWQgd2l0aCB0aGUga2VybmVsIG1vZHVsZQppaSAg
bnZpZGlhLWtlcm5lbC1zb3VyY2UtNTcwICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEt
MHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJ
RElBIGtlcm5lbCBzb3VyY2UgcGFja2FnZQppaSAgbnZpZGlhLWtlcm5lbC1zb3VyY2UtNTgw
ICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAg
ICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGtlcm5lbCBzb3VyY2UgcGFja2Fn
ZQppaSAgbnZpZGlhLXByaW1lICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAuOC4x
Ny4xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhbGwgICAgICAg
ICAgVG9vbHMgdG8gZW5hYmxlIE5WSURJQSdzIFByaW1lCmlpICBudmlkaWEtc2V0dGluZ3Mg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgNTEwLjQ3LjAzLTB1YnVudHUxLjIyLjA0LjEg
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBUb29sIGZvciBjb25maWd1cmlu
ZyB0aGUgTlZJRElBIGdyYXBoaWNzIGRyaXZlcgppaSAgbnZpZGlhLXV0aWxzLTU3MCAgICAg
ICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGRyaXZlciBzdXBwb3J0IGJp
bmFyaWVzCmlpICBudmlkaWEtdXRpbHMtNTgwICAgICAgICAgICAgICAgICAgICAgICAgICAg
NTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBOVklESUEgZHJpdmVyIHN1cHBvcnQgYmluYXJpZXMKaWkgIHNjcmVlbi1yZXNv
bHV0aW9uLWV4dHJhICAgICAgICAgICAgICAgICAgICAwLjE4LjJ1YnVudHUwLjEgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYWxsICAgICAgICAgIEV4dGVuc2lvbiBmb3Ig
dGhlIG52aWRpYS1zZXR0aW5ncyBjb250cm9sIHBhbmVsCmlpICB4c2VydmVyLXhvcmctdmlk
ZW8tbm91dmVhdSAgICAgICAgICAgICAgICAgMToxLjAuMTctMmJ1aWxkMSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBYLk9yZyBYIHNlcnZlciAtLSBO
b3V2ZWF1IGRpc3BsYXkgZHJpdmVyCmlpICB4c2VydmVyLXhvcmctdmlkZW8tbnZpZGlhLTU3
MCAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAg
ICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgYmluYXJ5IFhvcmcgZHJpdmVyCmlpICB4
c2VydmVyLXhvcmctdmlkZW8tbnZpZGlhLTU4MCAgICAgICAgICAgICAgNTgwLjE0Mi0wdWJ1
bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklE
SUEgYmluYXJ5IFhvcmcgZHJpdmVyCi0tLSBQQ0kgRFJJVkVSIFNUQVRVUyAtLS0KMDA6MDIu
MCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBXaGlza2V5
TGFrZS1VIEdUMiBbVUhEIEdyYXBoaWNzIDYyMF0KCVN1YnN5c3RlbTogQWNlciBJbmNvcnBv
cmF0ZWQgW0FMSV0gV2hpc2tleUxha2UtVSBHVDIgW1VIRCBHcmFwaGljcyA2MjBdCglLZXJu
ZWwgZHJpdmVyIGluIHVzZTogaTkxNQotLQowMjowMC4wIDNEIGNvbnRyb2xsZXI6IE5WSURJ
QSBDb3Jwb3JhdGlvbiBHUDEwOE0gW0dlRm9yY2UgTVgyNTBdIChyZXYgZmYpCglLZXJuZWwg
bW9kdWxlczogbnZpZGlhZmIsIG5vdXZlYXUsIG52aWRpYV9kcm0sIG52aWRpYQowNDowMC4w
IE5vbi1Wb2xhdGlsZSBtZW1vcnkgY29udHJvbGxlcjogTWljcm9uL0NydWNpYWwgVGVjaG5v
bG9neSBQMSBOVk1lIFBDSWUgU1NEIChyZXYgMDMpCi0tLSBHUFUgUkVOREVSRVIgLS0tCi0t
LSBOVklESUEtU01JIC0tLQpOVklESUEtU01JIGhhcyBmYWlsZWQgYmVjYXVzZSBpdCBjb3Vs
ZG4ndCBjb21tdW5pY2F0ZSB3aXRoIHRoZSBOVklESUEgZHJpdmVyLiBNYWtlIHN1cmUgdGhh
dCB0aGUgbGF0ZXN0IE5WSURJQSBkcml2ZXIgaXMgaW5zdGFsbGVkIGFuZCBydW5uaW5nLgoK
LS0tIFBPV0VSIE1BTkFHRU1FTlQgLS0tCkNvbnRyb2w6IGF1dG8KU3RhdHVzOiBzdXNwZW5k
ZWQKLS0tIExBU1QgMjAgUENJL05WSURJQSBMT0dTIC0tLQpbICA2MDkuNzgzOTUwXSBudmlk
aWE6IHByb2JlIG9mIDAwMDA6MDI6MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMQpbICA2MDku
Nzg0MDYyXSBOVlJNOiBUaGUgTlZJRElBIHByb2JlIHJvdXRpbmUgZmFpbGVkIGZvciAxIGRl
dmljZShzKS4KWyAgNjA5Ljc4NDA2OV0gTlZSTTogTm9uZSBvZiB0aGUgTlZJRElBIGRldmlj
ZXMgd2VyZSBpbml0aWFsaXplZC4KWyAgNjA5Ljc4ODU3OV0gbnZpZGlhLW52bGluazogVW5y
ZWdpc3RlcmVkIE52bGluayBDb3JlLCBtYWpvciBkZXZpY2UgbnVtYmVyIDUwOQpbICA2MTAu
NDU2ODE4XSBudmlkaWEtbnZsaW5rOiBOdmxpbmsgQ29yZSBpcyBiZWluZyBpbml0aWFsaXpl
ZCwgbWFqb3IgZGV2aWNlIG51bWJlciA1MDkKWyAgNjEwLjQ1NjgyNl0gTlZSTTogVGhlIE5W
SURJQSBHUFUgMDAwMDowMjowMC4wCiAgICAgICAgICAgICAgIE5WUk06IChQQ0kgSUQ6IDEw
ZGU6MWQxMykgaW5zdGFsbGVkIGluIHRoaXMgc3lzdGVtIGhhcwogICAgICAgICAgICAgICBO
VlJNOiBmYWxsZW4gb2ZmIHRoZSBidXMgYW5kIGlzIG5vdCByZXNwb25kaW5nIHRvIGNvbW1h
bmRzLgpbICA2MTAuNjA3NjAwXSBudmlkaWE6IHByb2JlIG9mIDAwMDA6MDI6MDAuMCBmYWls
ZWQgd2l0aCBlcnJvciAtMQpbICA2MTAuNjA3NzI3XSBOVlJNOiBUaGUgTlZJRElBIHByb2Jl
IHJvdXRpbmUgZmFpbGVkIGZvciAxIGRldmljZShzKS4KWyAgNjEwLjYwNzczNV0gTlZSTTog
Tm9uZSBvZiB0aGUgTlZJRElBIGRldmljZXMgd2VyZSBpbml0aWFsaXplZC4KWyAgNjEwLjYx
MzA1N10gbnZpZGlhLW52bGluazogVW5yZWdpc3RlcmVkIE52bGluayBDb3JlLCBtYWpvciBk
ZXZpY2UgbnVtYmVyIDUwOQpbICA2MTEuMjU4NTAyXSBudmlkaWEtbnZsaW5rOiBOdmxpbmsg
Q29yZSBpcyBiZWluZyBpbml0aWFsaXplZCwgbWFqb3IgZGV2aWNlIG51bWJlciA1MDkKWyAg
NjExLjI1ODUzOF0gTlZSTTogVGhlIE5WSURJQSBHUFUgMDAwMDowMjowMC4wCiAgICAgICAg
ICAgICAgIE5WUk06IChQQ0kgSUQ6IDEwZGU6MWQxMykgaW5zdGFsbGVkIGluIHRoaXMgc3lz
dGVtIGhhcwogICAgICAgICAgICAgICBOVlJNOiBmYWxsZW4gb2ZmIHRoZSBidXMgYW5kIGlz
IG5vdCByZXNwb25kaW5nIHRvIGNvbW1hbmRzLgpbICA2MTEuNDA3ODcyXSBudmlkaWE6IHBy
b2JlIG9mIDAwMDA6MDI6MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMQpbICA2MTEuNDA3OTk1
XSBOVlJNOiBUaGUgTlZJRElBIHByb2JlIHJvdXRpbmUgZmFpbGVkIGZvciAxIGRldmljZShz
KS4KWyAgNjExLjQwODAwMl0gTlZSTTogTm9uZSBvZiB0aGUgTlZJRElBIGRldmljZXMgd2Vy
ZSBpbml0aWFsaXplZC4KWyAgNjExLjQxMjYwMl0gbnZpZGlhLW52bGluazogVW5yZWdpc3Rl
cmVkIE52bGluayBDb3JlLCBtYWpvciBkZXZpY2UgbnVtYmVyIDUwOQo=
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu
 22-04-kernel6-1.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu
 22-04-kernel6-1.log"
Content-Transfer-Encoding: base64

LS0tIE9TICYgS0VSTkVMIC0tLQpCT09UX0lNQUdFPS9ib290L3ZtbGludXotNi4xLjc3LXg2
NHYzLXhhbm1vZDEgcm9vdD1VVUlEPWU4MmZmYWVjLWY0MGItNGM4Mi04ODY1LTcyZmVhMDU3
NWZjYiBybyBxdWlldCBzcGxhc2ggdnQuaGFuZG9mZj03CkRpc3RyaWJ1dG9yIElEOglVYnVu
dHUKRGVzY3JpcHRpb246CVVidW50dSAyMi4wNC41IExUUwpSZWxlYXNlOgkyMi4wNApDb2Rl
bmFtZToJamFtbXkKTGludXggbHh1c2VyLVN3aWZ0LVNGMzE0LTU2RyA2LjEuNzcteDY0djMt
eGFubW9kMSAjMH4yMDI0MDIwNi5nOGM2MmY0MSBTTVAgUFJFRU1QVF9EWU5BTUlDIFR1ZSBG
ZWIgIDYgMTc6MzI6MzIgVVRDIHg4Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAotLS0g
U0VTU0lPTiBUWVBFIC0tLQp3YXlsYW5kCi0tLSBJTlNUQUxMRUQgUEFDS0FHRVMgKE5WSURJ
QS9NRVNBKSAtLS0KaWkgIGxpYmRybS1ub3V2ZWF1MjphbWQ2NCAgICAgICAgICAgICAgICAg
ICAgICAyLjQuMTEzLTJ+dWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgICAg
YW1kNjQgICAgICAgIFVzZXJzcGFjZSBpbnRlcmZhY2UgdG8gbm91dmVhdS1zcGVjaWZpYyBr
ZXJuZWwgRFJNIHNlcnZpY2VzIC0tIHJ1bnRpbWUKaWkgIGxpYmVnbC1tZXNhMDphbWQ2NCAg
ICAgICAgICAgICAgICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAg
ICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIGZyZWUgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIEVHTCBBUEkgLS0gTWVzYSB2ZW5kb3IgbGlicmFyeQppaSAgbGliZ2wxLW1lc2EtZHJp
OmFtZDY0ICAgICAgICAgICAgICAgICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMg
ICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgZnJlZSBpbXBsZW1lbnRhdGlv
biBvZiB0aGUgT3BlbkdMIEFQSSAtLSBEUkkgbW9kdWxlcwppaSAgbGliZ2xhcGktbWVzYTph
bWQ2NCAgICAgICAgICAgICAgICAgICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMg
ICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgZnJlZSBpbXBsZW1lbnRhdGlv
biBvZiB0aGUgR0wgQVBJIC0tIHNoYXJlZCBsaWJyYXJ5CmlpICBsaWJnbHUxLW1lc2E6YW1k
NjQgICAgICAgICAgICAgICAgICAgICAgICAgOS4wLjItMSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNZXNhIE9wZW5HTCB1dGlsaXR5
IGxpYnJhcnkgKEdMVSkKaWkgIGxpYmdseC1tZXNhMDphbWQ2NCAgICAgICAgICAgICAgICAg
ICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAgICAg
ICAgYW1kNjQgICAgICAgIGZyZWUgaW1wbGVtZW50YXRpb24gb2YgdGhlIE9wZW5HTCBBUEkg
LS0gR0xYIHZlbmRvciBsaWJyYXJ5CmlpICBsaWJudmlkaWEtY2ZnMS01NzA6YW1kNjQgICAg
ICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAg
ICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgYmluYXJ5IE9wZW5HTC9HTFggY29uZmln
dXJhdGlvbiBsaWJyYXJ5CmlpICBsaWJudmlkaWEtY2ZnMS01ODA6YW1kNjQgICAgICAgICAg
ICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZDY0ICAgICAgICBOVklESUEgYmluYXJ5IE9wZW5HTC9HTFggY29uZmlndXJhdGlv
biBsaWJyYXJ5CmlpICBsaWJudmlkaWEtY29tbW9uLTU3MCAgICAgICAgICAgICAgICAgICAg
ICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFs
bCAgICAgICAgICBTaGFyZWQgZmlsZXMgdXNlZCBieSB0aGUgTlZJRElBIGxpYnJhcmllcwpp
aSAgbGlibnZpZGlhLWNvbW1vbi01ODAgICAgICAgICAgICAgICAgICAgICAgIDU4MC4xNDIt
MHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgICBhbGwgICAgICAgICAg
U2hhcmVkIGZpbGVzIHVzZWQgYnkgdGhlIE5WSURJQSBsaWJyYXJpZXMKaWkgIGxpYm52aWRp
YS1jb21wdXRlLTU3MDphbWQ2NCAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUx
LjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBsaWJj
b21wdXRlIHBhY2thZ2UKaWkgIGxpYm52aWRpYS1jb21wdXRlLTU3MDppMzg2ICAgICAgICAg
ICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUxLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgaTM4NiAgICAgICAgIE5WSURJQSBsaWJjb21wdXRlIHBhY2thZ2UKaWkgIGxpYm52aWRp
YS1jb21wdXRlLTU4MDphbWQ2NCAgICAgICAgICAgICAgICA1ODAuMTQyLTB1YnVudHUwLjIy
LjA0LjEgICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBsaWJj
b21wdXRlIHBhY2thZ2UKaWkgIGxpYm52aWRpYS1jb21wdXRlLTU4MDppMzg2ICAgICAgICAg
ICAgICAgICA1ODAuMTQyLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAg
ICAgaTM4NiAgICAgICAgIE5WSURJQSBsaWJjb21wdXRlIHBhY2thZ2UKaWkgIGxpYm52aWRp
YS1kZWNvZGUtNTcwOmFtZDY0ICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUx
LjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBWaWRl
byBEZWNvZGluZyBydW50aW1lIGxpYnJhcmllcwppaSAgbGlibnZpZGlhLWRlY29kZS01NzA6
aTM4NiAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZJRElBIFZpZGVvIERlY29kaW5nIHJ1
bnRpbWUgbGlicmFyaWVzCmlpICBsaWJudmlkaWEtZGVjb2RlLTU4MDphbWQ2NCAgICAgICAg
ICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZDY0ICAgICAgICBOVklESUEgVmlkZW8gRGVjb2RpbmcgcnVudGltZSBsaWJyYXJp
ZXMKaWkgIGxpYm52aWRpYS1kZWNvZGUtNTgwOmkzODYgICAgICAgICAgICAgICAgICA1ODAu
MTQyLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgICAgaTM4NiAgICAg
ICAgIE5WSURJQSBWaWRlbyBEZWNvZGluZyBydW50aW1lIGxpYnJhcmllcwppaSAgbGlibnZp
ZGlhLWVnbC13YXlsYW5kMTphbWQ2NCAgICAgICAgICAgICAgIDE6MS4xLjE3LTB1YnVudHUw
fmdwdTIyLjA0LjEgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgV2F5bGFuZCBF
R0wgRXh0ZXJuYWwgUGxhdGZvcm0gbGlicmFyeSAtLSBzaGFyZWQgbGlicmFyeQppaSAgbGli
bnZpZGlhLWVnbC13YXlsYW5kMTppMzg2ICAgICAgICAgICAgICAgIDE6MS4xLjE3LTB1YnVu
dHUwfmdwdTIyLjA0LjEgICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgV2F5bGFu
ZCBFR0wgRXh0ZXJuYWwgUGxhdGZvcm0gbGlicmFyeSAtLSBzaGFyZWQgbGlicmFyeQppaSAg
bGlibnZpZGlhLWVuY29kZS01NzA6YW1kNjQgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEt
MHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZF
TkMgVmlkZW8gRW5jb2RpbmcgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZW5jb2Rl
LTU3MDppMzg2ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4x
ICAgICAgICAgICAgICAgICAgICAgIGkzODYgICAgICAgICBOVkVOQyBWaWRlbyBFbmNvZGlu
ZyBydW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1lbmNvZGUtNTgwOmFtZDY0ICAgICAg
ICAgICAgICAgICA1ODAuMTQyLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgICAgYW1kNjQgICAgICAgIE5WRU5DIFZpZGVvIEVuY29kaW5nIHJ1bnRpbWUgbGlicmFy
eQppaSAgbGlibnZpZGlhLWVuY29kZS01ODA6aTM4NiAgICAgICAgICAgICAgICAgIDU4MC4x
NDItMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAg
ICAgTlZFTkMgVmlkZW8gRW5jb2RpbmcgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEt
ZXh0cmEtNTcwOmFtZDY0ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4y
Mi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBFeHRyYSBsaWJyYXJp
ZXMgZm9yIHRoZSBOVklESUEgZHJpdmVyCmlpICBsaWJudmlkaWEtZXh0cmEtNTgwOmFtZDY0
ICAgICAgICAgICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAg
ICAgICAgICAgICAgIGFtZDY0ICAgICAgICBFeHRyYSBsaWJyYXJpZXMgZm9yIHRoZSBOVklE
SUEgZHJpdmVyCmlpICBsaWJudmlkaWEtZmJjMS01NzA6YW1kNjQgICAgICAgICAgICAgICAg
ICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFt
ZDY0ICAgICAgICBOVklESUEgT3BlbkdMLWJhc2VkIEZyYW1lYnVmZmVyIENhcHR1cmUgcnVu
dGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZmJjMS01NzA6aTM4NiAgICAgICAgICAgICAg
ICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAg
IGkzODYgICAgICAgICBOVklESUEgT3BlbkdMLWJhc2VkIEZyYW1lYnVmZmVyIENhcHR1cmUg
cnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZmJjMS01ODA6YW1kNjQgICAgICAgICAg
ICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZDY0ICAgICAgICBOVklESUEgT3BlbkdMLWJhc2VkIEZyYW1lYnVmZmVyIENhcHR1
cmUgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZmJjMS01ODA6aTM4NiAgICAgICAg
ICAgICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAg
ICAgICAgIGkzODYgICAgICAgICBOVklESUEgT3BlbkdMLWJhc2VkIEZyYW1lYnVmZmVyIENh
cHR1cmUgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZ2wtNTcwOmFtZDY0ICAgICAg
ICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAgICAg
ICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgT3BlbkdML0dMWC9FR0wvR0xFUyBHTFZO
RCBsaWJyYXJpZXMgYW5kIFZ1bGthbiBJQ0QKaWkgIGxpYm52aWRpYS1nbC01ODA6YW1kNjQg
ICAgICAgICAgICAgICAgICAgICA1ODAuMTQyLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAg
ICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5WSURJQSBPcGVuR0wvR0xYL0VHTC9HTEVT
IEdMVk5EIGxpYnJhcmllcyBhbmQgVnVsa2FuIElDRAppaSAgbGlibnZpZGlhLWdsLTU4MDpp
Mzg2ICAgICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAgICAg
ICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZJRElBIE9wZW5HTC9HTFgvRUdM
L0dMRVMgR0xWTkQgbGlicmFyaWVzIGFuZCBWdWxrYW4gSUNECmlpICBtZXNhLXV0aWxzICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOC40LjAtMXVidW50dTEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNaXNjZWxsYW5lb3VzIE1l
c2EgdXRpbGl0aWVzIC0tIHN5bWxpbmtzCmlpICBtZXNhLXV0aWxzLWJpbjphbWQ2NCAgICAg
ICAgICAgICAgICAgICAgICAgOC40LjAtMXVidW50dTEgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNaXNjZWxsYW5lb3VzIE1lc2EgdXRpbGl0aWVz
IC0tIG5hdGl2ZSBhcHBsaWNhdGlvbnMKaWkgIG1lc2EtdmEtZHJpdmVyczphbWQ2NCAgICAg
ICAgICAgICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAg
ICAgICAgICAgICAgYW1kNjQgICAgICAgIE1lc2EgVkEtQVBJIHZpZGVvIGFjY2VsZXJhdGlv
biBkcml2ZXJzCmlpICBtZXNhLXZkcGF1LWRyaXZlcnM6YW1kNjQgICAgICAgICAgICAgICAg
ICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFt
ZDY0ICAgICAgICBNZXNhIFZEUEFVIHZpZGVvIGFjY2VsZXJhdGlvbiBkcml2ZXJzCmlpICBt
ZXNhLXZ1bGthbi1kcml2ZXJzOmFtZDY0ICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVu
dHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNZXNh
IFZ1bGthbiBncmFwaGljcyBkcml2ZXJzCmlpICBudmlkaWEtY29tcHV0ZS11dGlscy01NzAg
ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MS4yMi4wNC4xICAgICAgICAg
ICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgY29tcHV0ZSB1dGlsaXRpZXMKaWkg
IG52aWRpYS1jb21wdXRlLXV0aWxzLTU4MCAgICAgICAgICAgICAgICAgICA1ODAuMTQyLTB1
YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5W
SURJQSBjb21wdXRlIHV0aWxpdGllcwppaSAgbnZpZGlhLWRrbXMtNTcwICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAgICAgICAg
ICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIERLTVMgcGFja2FnZQppaSAgbnZpZGlh
LWRrbXMtNTgwICAgICAgICAgICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAu
MjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIERL
TVMgcGFja2FnZQppaSAgbnZpZGlhLWRyaXZlci01NzAgICAgICAgICAgICAgICAgICAgICAg
ICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgTlZJRElBIGRyaXZlciBtZXRhcGFja2FnZQppaSAgbnZpZGlhLWRyaXZl
ci01ODAgICAgICAgICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQu
MSAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGRyaXZlciBt
ZXRhcGFja2FnZQppaSAgbnZpZGlhLWZpcm13YXJlLTU3MC01NzAuMjExLjAxICAgICAgICAg
ICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgRmlybXdhcmUgZmlsZXMgdXNlZCBieSB0aGUga2VybmVsIG1vZHVsZQpp
aSAgbnZpZGlhLWZpcm13YXJlLTU4MC01ODAuMTQyICAgICAgICAgICAgICAgIDU4MC4xNDIt
MHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAg
RmlybXdhcmUgZmlsZXMgdXNlZCBieSB0aGUga2VybmVsIG1vZHVsZQppaSAgbnZpZGlhLWtl
cm5lbC1jb21tb24tNTcwICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEu
MjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgU2hhcmVkIGZpbGVz
IHVzZWQgd2l0aCB0aGUga2VybmVsIG1vZHVsZQppaSAgbnZpZGlhLWtlcm5lbC1jb21tb24t
NTgwICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50dTAuMjIuMDQuMSAgICAgICAg
ICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgU2hhcmVkIGZpbGVzIHVzZWQgd2l0aCB0
aGUga2VybmVsIG1vZHVsZQppaSAgbnZpZGlhLWtlcm5lbC1zb3VyY2UtNTcwICAgICAgICAg
ICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAg
ICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGtlcm5lbCBzb3VyY2UgcGFja2FnZQppaSAgbnZp
ZGlhLWtlcm5lbC1zb3VyY2UtNTgwICAgICAgICAgICAgICAgICAgIDU4MC4xNDItMHVidW50
dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElB
IGtlcm5lbCBzb3VyY2UgcGFja2FnZQppaSAgbnZpZGlhLXByaW1lICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDAuOC4xNy4xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhbGwgICAgICAgICAgVG9vbHMgdG8gZW5hYmxlIE5WSURJQSdzIFByaW1l
CmlpICBudmlkaWEtc2V0dGluZ3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTEwLjQ3
LjAzLTB1YnVudHUxLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAg
ICBUb29sIGZvciBjb25maWd1cmluZyB0aGUgTlZJRElBIGdyYXBoaWNzIGRyaXZlcgppaSAg
bnZpZGlhLXV0aWxzLTU3MCAgICAgICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEt
MHVidW50dTEuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJ
RElBIGRyaXZlciBzdXBwb3J0IGJpbmFyaWVzCmlpICBudmlkaWEtdXRpbHMtNTgwICAgICAg
ICAgICAgICAgICAgICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAg
ICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgZHJpdmVyIHN1cHBvcnQgYmlu
YXJpZXMKaWkgIHNjcmVlbi1yZXNvbHV0aW9uLWV4dHJhICAgICAgICAgICAgICAgICAgICAw
LjE4LjJ1YnVudHUwLjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWxsICAg
ICAgICAgIEV4dGVuc2lvbiBmb3IgdGhlIG52aWRpYS1zZXR0aW5ncyBjb250cm9sIHBhbmVs
CmlpICB4c2VydmVyLXhvcmctdmlkZW8tbm91dmVhdSAgICAgICAgICAgICAgICAgMToxLjAu
MTctMmJ1aWxkMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAg
ICBYLk9yZyBYIHNlcnZlciAtLSBOb3V2ZWF1IGRpc3BsYXkgZHJpdmVyCmlpICB4c2VydmVy
LXhvcmctdmlkZW8tbnZpZGlhLTU3MCAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1
MS4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgYmlu
YXJ5IFhvcmcgZHJpdmVyCmlpICB4c2VydmVyLXhvcmctdmlkZW8tbnZpZGlhLTU4MCAgICAg
ICAgICAgICAgNTgwLjE0Mi0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAg
ICAgIGFtZDY0ICAgICAgICBOVklESUEgYmluYXJ5IFhvcmcgZHJpdmVyCi0tLSBQQ0kgRFJJ
VkVSIFNUQVRVUyAtLS0KMDA6MDIuMCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBJbnRl
bCBDb3Jwb3JhdGlvbiBXaGlza2V5TGFrZS1VIEdUMiBbVUhEIEdyYXBoaWNzIDYyMF0KCVN1
YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gV2hpc2tleUxha2UtVSBHVDIgW1VI
RCBHcmFwaGljcyA2MjBdCglLZXJuZWwgZHJpdmVyIGluIHVzZTogaTkxNQotLQowMjowMC4w
IDNEIGNvbnRyb2xsZXI6IE5WSURJQSBDb3Jwb3JhdGlvbiBHUDEwOE0gW0dlRm9yY2UgTVgy
NTBdIChyZXYgZmYpCglLZXJuZWwgbW9kdWxlczogbnZpZGlhZmIsIG5vdXZlYXUsIG52aWRp
YV9kcm0sIG52aWRpYQowNDowMC4wIE5vbi1Wb2xhdGlsZSBtZW1vcnkgY29udHJvbGxlcjog
TWljcm9uL0NydWNpYWwgVGVjaG5vbG9neSBQMSBOVk1lIFBDSWUgU1NEIChyZXYgMDMpCi0t
LSBHUFUgUkVOREVSRVIgLS0tCi0tLSBOVklESUEtU01JIC0tLQpOVklESUEtU01JIGhhcyBm
YWlsZWQgYmVjYXVzZSBpdCBjb3VsZG4ndCBjb21tdW5pY2F0ZSB3aXRoIHRoZSBOVklESUEg
ZHJpdmVyLiBNYWtlIHN1cmUgdGhhdCB0aGUgbGF0ZXN0IE5WSURJQSBkcml2ZXIgaXMgaW5z
dGFsbGVkIGFuZCBydW5uaW5nLgoKLS0tIFBPV0VSIE1BTkFHRU1FTlQgLS0tCkNvbnRyb2w6
IGF1dG8KU3RhdHVzOiBzdXNwZW5kZWQKLS0tIExBU1QgMjAgUENJL05WSURJQSBMT0dTIC0t
LQogICAgICAgICAgICAgICBOVlJNOiAoUENJIElEOiAxMGRlOjFkMTMpIGluc3RhbGxlZCBp
biB0aGlzIHN5c3RlbSBoYXMKICAgICAgICAgICAgICAgTlZSTTogZmFsbGVuIG9mZiB0aGUg
YnVzIGFuZCBpcyBub3QgcmVzcG9uZGluZyB0byBjb21tYW5kcy4KWyAgMzUxLjI3OTI5OF0g
bnZpZGlhOiBwcm9iZSBvZiAwMDAwOjAyOjAwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTEKWyAg
MzUxLjI3OTMyM10gTlZSTTogVGhlIE5WSURJQSBwcm9iZSByb3V0aW5lIGZhaWxlZCBmb3Ig
MSBkZXZpY2UocykuClsgIDM1MS4yNzkzMjRdIE5WUk06IE5vbmUgb2YgdGhlIE5WSURJQSBk
ZXZpY2VzIHdlcmUgaW5pdGlhbGl6ZWQuClsgIDM1MS4yODA4NjhdIG52aWRpYS1udmxpbms6
IFVucmVnaXN0ZXJlZCBOdmxpbmsgQ29yZSwgbWFqb3IgZGV2aWNlIG51bWJlciA1MDcKWyAg
MzUxLjU5MDE0MF0gbnZpZGlhLW52bGluazogTnZsaW5rIENvcmUgaXMgYmVpbmcgaW5pdGlh
bGl6ZWQsIG1ham9yIGRldmljZSBudW1iZXIgNTA3ClsgIDM1Mi45MDA4MzddIHBjaSAwMDAw
OjAyOjAwLjA6IG5vdCByZWFkeSAxMDIzbXMgYWZ0ZXIgcmVzdW1lOyBnaXZpbmcgdXAKWyAg
MzUyLjkwMDg5Ml0gcGNpIDAwMDA6MDI6MDAuMDogVW5hYmxlIHRvIGNoYW5nZSBwb3dlciBz
dGF0ZSBmcm9tIEQzY29sZCB0byBEMCwgZGV2aWNlIGluYWNjZXNzaWJsZQpbICAzNTIuOTA1
MjA4XSBudmlkaWEgMDAwMDowMjowMC4wOiBVbmFibGUgdG8gY2hhbmdlIHBvd2VyIHN0YXRl
IGZyb20gRDNjb2xkIHRvIEQwLCBkZXZpY2UgaW5hY2Nlc3NpYmxlClsgIDM1Mi45MDU0Mzhd
IE5WUk06IFRoZSBOVklESUEgR1BVIDAwMDA6MDI6MDAuMAogICAgICAgICAgICAgICBOVlJN
OiAoUENJIElEOiAxMGRlOjFkMTMpIGluc3RhbGxlZCBpbiB0aGlzIHN5c3RlbSBoYXMKICAg
ICAgICAgICAgICAgTlZSTTogZmFsbGVuIG9mZiB0aGUgYnVzIGFuZCBpcyBub3QgcmVzcG9u
ZGluZyB0byBjb21tYW5kcy4KWyAgMzUyLjkwODgzN10gbnZpZGlhOiBwcm9iZSBvZiAwMDAw
OjAyOjAwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTEKWyAgMzUyLjkwODg2OF0gTlZSTTogVGhl
IE5WSURJQSBwcm9iZSByb3V0aW5lIGZhaWxlZCBmb3IgMSBkZXZpY2UocykuClsgIDM1Mi45
MDg4NjldIE5WUk06IE5vbmUgb2YgdGhlIE5WSURJQSBkZXZpY2VzIHdlcmUgaW5pdGlhbGl6
ZWQuClsgIDM1Mi45MTA0OTZdIG52aWRpYS1udmxpbms6IFVucmVnaXN0ZXJlZCBOdmxpbmsg
Q29yZSwgbWFqb3IgZGV2aWNlIG51bWJlciA1MDcKWyAgMzUzLjIwODAwNF0gbnZpZGlhLW52
bGluazogTnZsaW5rIENvcmUgaXMgYmVpbmcgaW5pdGlhbGl6ZWQsIG1ham9yIGRldmljZSBu
dW1iZXIgNTA3ClsgIDM1NC41MDAyMTZdIHBjaSAwMDAwOjAyOjAwLjA6IG5vdCByZWFkeSAx
MDIzbXMgYWZ0ZXIgcmVzdW1lOyBnaXZpbmcgdXAKWyAgMzU0LjUwMDI2MV0gcGNpIDAwMDA6
MDI6MDAuMDogVW5hYmxlIHRvIGNoYW5nZSBwb3dlciBzdGF0ZSBmcm9tIEQzY29sZCB0byBE
MCwgZGV2aWNlIGluYWNjZXNzaWJsZQo=
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu
 22-04-on_xorg.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu
 22-04-on_xorg.log"
Content-Transfer-Encoding: base64

LS0tIE9TICYgS0VSTkVMIC0tLQpEaXN0cmlidXRvciBJRDoJVWJ1bnR1CkRlc2NyaXB0aW9u
OglVYnVudHUgMjIuMDQuNSBMVFMKUmVsZWFzZToJMjIuMDQKQ29kZW5hbWU6CWphbW15Ckxp
bnV4IGx4dXNlci1Td2lmdC1TRjMxNC01NkcgNi44LjAtMTEwLWdlbmVyaWMgIzExMH4yMi4w
NC4xLVVidW50dSBTTVAgUFJFRU1QVF9EWU5BTUlDIEZyaSBNYXIgMjcgMTI6NDM6MDggVVRD
ICB4ODZfNjQgeDg2XzY0IHg4Nl82NCBHTlUvTGludXgKLS0tIFNFU1NJT04gVFlQRSAtLS0K
eDExCi0tLSBJTlNUQUxMRUQgUEFDS0FHRVMgKE5WSURJQS9NRVNBKSAtLS0KaWkgIGxpYmRy
bS1ub3V2ZWF1MjphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAyLjQuMTEzLTJ+dWJ1bnR1
MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFVzZXJzcGFj
ZSBpbnRlcmZhY2UgdG8gbm91dmVhdS1zcGVjaWZpYyBrZXJuZWwgRFJNIHNlcnZpY2VzIC0t
IHJ1bnRpbWUKaWkgIGxpYmVnbC1tZXNhMDphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAg
ICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAgICAgICAgYW1k
NjQgICAgICAgIGZyZWUgaW1wbGVtZW50YXRpb24gb2YgdGhlIEVHTCBBUEkgLS0gTWVzYSB2
ZW5kb3IgbGlicmFyeQppaSAgbGliZ2wxLW1lc2EtZHJpOmFtZDY0ICAgICAgICAgICAgICAg
ICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAg
ICBhbWQ2NCAgICAgICAgZnJlZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgT3BlbkdMIEFQSSAt
LSBEUkkgbW9kdWxlcwppaSAgbGliZ2xhcGktbWVzYTphbWQ2NCAgICAgICAgICAgICAgICAg
ICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAg
ICBhbWQ2NCAgICAgICAgZnJlZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgR0wgQVBJIC0tIHNo
YXJlZCBsaWJyYXJ5CmlpICBsaWJnbHUxLW1lc2E6YW1kNjQgICAgICAgICAgICAgICAgICAg
ICAgICAgOS4wLjItMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGFtZDY0ICAgICAgICBNZXNhIE9wZW5HTCB1dGlsaXR5IGxpYnJhcnkgKEdMVSkKaWkgIGxp
YmdseC1tZXNhMDphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAgICAyMy4yLjEtMXVidW50
dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIGZyZWUg
aW1wbGVtZW50YXRpb24gb2YgdGhlIE9wZW5HTCBBUEkgLS0gR0xYIHZlbmRvciBsaWJyYXJ5
CmlpICBsaWJudmlkaWEtY2ZnMS01NzA6YW1kNjQgICAgICAgICAgICAgICAgICAgNTcwLjIx
MS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAg
ICBOVklESUEgYmluYXJ5IE9wZW5HTC9HTFggY29uZmlndXJhdGlvbiBsaWJyYXJ5CmlpICBs
aWJudmlkaWEtY29tbW9uLTU3MCAgICAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0w
dWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBTaGFy
ZWQgZmlsZXMgdXNlZCBieSB0aGUgTlZJRElBIGxpYnJhcmllcwppaSAgbGlibnZpZGlhLWNv
bXB1dGUtNTcwOmFtZDY0ICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIu
MDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGxpYmNvbXB1
dGUgcGFja2FnZQppaSAgbGlibnZpZGlhLWNvbXB1dGUtNTcwOmkzODYgICAgICAgICAgICAg
ICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBp
Mzg2ICAgICAgICAgTlZJRElBIGxpYmNvbXB1dGUgcGFja2FnZQppaSAgbGlibnZpZGlhLWRl
Y29kZS01NzA6YW1kNjQgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIu
MDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIFZpZGVvIERl
Y29kaW5nIHJ1bnRpbWUgbGlicmFyaWVzCmlpICBsaWJudmlkaWEtZGVjb2RlLTU3MDppMzg2
ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAg
ICAgICAgICAgICAgIGkzODYgICAgICAgICBOVklESUEgVmlkZW8gRGVjb2RpbmcgcnVudGlt
ZSBsaWJyYXJpZXMKaWkgIGxpYm52aWRpYS1lZ2wtd2F5bGFuZDE6YW1kNjQgICAgICAgICAg
ICAgICAxOjEuMS45LTEuMXVidW50dTAuMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YW1kNjQgICAgICAgIFdheWxhbmQgRUdMIEV4dGVybmFsIFBsYXRmb3JtIGxpYnJhcnkgLS0g
c2hhcmVkIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1lbmNvZGUtNTcwOmFtZDY0ICAgICAgICAg
ICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgYW1kNjQgICAgICAgIE5WRU5DIFZpZGVvIEVuY29kaW5nIHJ1bnRpbWUgbGlicmFyeQpp
aSAgbGlibnZpZGlhLWVuY29kZS01NzA6aTM4NiAgICAgICAgICAgICAgICAgIDU3MC4yMTEu
MDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAg
TlZFTkMgVmlkZW8gRW5jb2RpbmcgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZXh0
cmEtNTcwOmFtZDY0ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4w
NC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBFeHRyYSBsaWJyYXJpZXMg
Zm9yIHRoZSBOVklESUEgZHJpdmVyCmlpICBsaWJudmlkaWEtZmJjMS01NzA6YW1kNjQgICAg
ICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAg
ICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgT3BlbkdMLWJhc2VkIEZyYW1lYnVmZmVy
IENhcHR1cmUgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZmJjMS01NzA6aTM4NiAg
ICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAg
ICAgICAgICAgICAgIGkzODYgICAgICAgICBOVklESUEgT3BlbkdMLWJhc2VkIEZyYW1lYnVm
ZmVyIENhcHR1cmUgcnVudGltZSBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZ2wtNTcwOmFtZDY0
ICAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAg
ICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgT3BlbkdML0dMWC9FR0wvR0xF
UyBHTFZORCBsaWJyYXJpZXMgYW5kIFZ1bGthbiBJQ0QKaWkgIG1lc2EtdXRpbHMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICA4LjQuMC0xdWJ1bnR1MSAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE1pc2NlbGxhbmVvdXMgTWVzYSB1
dGlsaXRpZXMgLS0gc3ltbGlua3MKaWkgIG1lc2EtdXRpbHMtYmluOmFtZDY0ICAgICAgICAg
ICAgICAgICAgICAgICA4LjQuMC0xdWJ1bnR1MSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYW1kNjQgICAgICAgIE1pc2NlbGxhbmVvdXMgTWVzYSB1dGlsaXRpZXMgLS0g
bmF0aXZlIGFwcGxpY2F0aW9ucwppaSAgbWVzYS12ZHBhdS1kcml2ZXJzOmFtZDY0ICAgICAg
ICAgICAgICAgICAgIDIzLjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAg
ICAgICAgICBhbWQ2NCAgICAgICAgTWVzYSBWRFBBVSB2aWRlbyBhY2NlbGVyYXRpb24gZHJp
dmVycwppaSAgbWVzYS12dWxrYW4tZHJpdmVyczphbWQ2NCAgICAgICAgICAgICAgICAgIDIz
LjIuMS0xdWJ1bnR1My4xfjIyLjA0LjMgICAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgTWVzYSBWdWxrYW4gZ3JhcGhpY3MgZHJpdmVycwppaSAgbnZpZGlhLWNvbXB1dGUt
dXRpbHMtNTcwICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQu
MSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGNvbXB1dGUgdXRp
bGl0aWVzCmlpICBudmlkaWEtZGttcy01NzAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
NTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBOVklESUEgREtNUyBwYWNrYWdlCmlpICBudmlkaWEtZHJpdmVyLTU3MCAgICAg
ICAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAg
ICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgZHJpdmVyIG1ldGFwYWNrYWdl
CmlpICBudmlkaWEtZmlybXdhcmUtNTcwLTU3MC4yMTEuMDEgICAgICAgICAgICAgNTcwLjIx
MS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAg
ICBGaXJtd2FyZSBmaWxlcyB1c2VkIGJ5IHRoZSBrZXJuZWwgbW9kdWxlCmlpICBudmlkaWEt
a2VybmVsLWNvbW1vbi01NzAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1
MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBTaGFyZWQgZmls
ZXMgdXNlZCB3aXRoIHRoZSBrZXJuZWwgbW9kdWxlCmlpICBudmlkaWEta2VybmVsLXNvdXJj
ZS01NzAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEga2VybmVsIHNvdXJjZSBw
YWNrYWdlCmlpICBudmlkaWEtcHJpbWUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
MC44LjE3LjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFsbCAg
ICAgICAgICBUb29scyB0byBlbmFibGUgTlZJRElBJ3MgUHJpbWUKaWkgIG52aWRpYS1zZXR0
aW5ncyAgICAgICAgICAgICAgICAgICAgICAgICAgICA1MTAuNDcuMDMtMHVidW50dTEuMjIu
MDQuMSAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIFRvb2wgZm9yIGNvbmZp
Z3VyaW5nIHRoZSBOVklESUEgZ3JhcGhpY3MgZHJpdmVyCmlpICBudmlkaWEtdXRpbHMtNTcw
ICAgICAgICAgICAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4x
ICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklESUEgZHJpdmVyIHN1cHBv
cnQgYmluYXJpZXMKaWkgIHNjcmVlbi1yZXNvbHV0aW9uLWV4dHJhICAgICAgICAgICAgICAg
ICAgICAwLjE4LjJ1YnVudHUwLjEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
YWxsICAgICAgICAgIEV4dGVuc2lvbiBmb3IgdGhlIG52aWRpYS1zZXR0aW5ncyBjb250cm9s
IHBhbmVsCmlpICB4c2VydmVyLXhvcmctdmlkZW8tbm91dmVhdSAgICAgICAgICAgICAgICAg
MToxLjAuMTctMmJ1aWxkMSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBYLk9yZyBYIHNlcnZlciAtLSBOb3V2ZWF1IGRpc3BsYXkgZHJpdmVyCmlpICB4
c2VydmVyLXhvcmctdmlkZW8tbnZpZGlhLTU3MCAgICAgICAgICAgICAgNTcwLjIxMS4wMS0w
dWJ1bnR1MC4yMi4wNC4xICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVklE
SUEgYmluYXJ5IFhvcmcgZHJpdmVyCi0tLSBQQ0kgRFJJVkVSIFNUQVRVUyAtLS0KMDA6MDIu
MCBWR0EgY29tcGF0aWJsZSBjb250cm9sbGVyOiBJbnRlbCBDb3Jwb3JhdGlvbiBXaGlza2V5
TGFrZS1VIEdUMiBbVUhEIEdyYXBoaWNzIDYyMF0KCVN1YnN5c3RlbTogQWNlciBJbmNvcnBv
cmF0ZWQgW0FMSV0gV2hpc2tleUxha2UtVSBHVDIgW1VIRCBHcmFwaGljcyA2MjBdCglLZXJu
ZWwgZHJpdmVyIGluIHVzZTogaTkxNQotLQowMjowMC4wIDNEIGNvbnRyb2xsZXI6IE5WSURJ
QSBDb3Jwb3JhdGlvbiBHUDEwOE0gW0dlRm9yY2UgTVgyNTBdIChyZXYgZmYpCglLZXJuZWwg
bW9kdWxlczogbnZpZGlhZmIsIG5vdXZlYXUsIG52aWRpYV9kcm0sIG52aWRpYQowNDowMC4w
IE5vbi1Wb2xhdGlsZSBtZW1vcnkgY29udHJvbGxlcjogTWljcm9uL0NydWNpYWwgVGVjaG5v
bG9neSBQMSBOVk1lIFBDSWUgU1NEIChyZXYgMDMpCi0tLSBHUFUgUkVOREVSRVIgLS0tCi0t
LSBOVklESUEtU01JIC0tLQpOVklESUEtU01JIGhhcyBmYWlsZWQgYmVjYXVzZSBpdCBjb3Vs
ZG4ndCBjb21tdW5pY2F0ZSB3aXRoIHRoZSBOVklESUEgZHJpdmVyLiBNYWtlIHN1cmUgdGhh
dCB0aGUgbGF0ZXN0IE5WSURJQSBkcml2ZXIgaXMgaW5zdGFsbGVkIGFuZCBydW5uaW5nLgoK
LS0tIFBPV0VSIE1BTkFHRU1FTlQgLS0tCkNvbnRyb2w6IGF1dG8KU3RhdHVzOiBzdXNwZW5k
ZWQKLS0tIExBU1QgMjAgUENJL05WSURJQSBMT0dTIC0tLQogICAgICAgICAgICAgICBOVlJN
OiBhIG1hdGNoaW5nIHByZWZldGNoYWJsZSBtZW1vcnkgd2luZG93LgpbICA1NzAuMjYyOTMx
XSBOVlJNOiBUaGlzIG1heSBiZSBkdWUgdG8gYSBrbm93biBMaW51eCBrZXJuZWwgYnVnLiAg
UGxlYXNlCiAgICAgICAgICAgICAgIE5WUk06IHNlZSB0aGUgUkVBRE1FIHNlY3Rpb24gb24g
NjQtYml0IEJBUnMgZm9yIGFkZGl0aW9uYWwKICAgICAgICAgICAgICAgTlZSTTogaW5mb3Jt
YXRpb24uClsgIDU3MC4yNjI5OTddIG52aWRpYTogcHJvYmUgb2YgMDAwMDowMjowMC4wIGZh
aWxlZCB3aXRoIGVycm9yIC0xClsgIDU3MC4yNjMwODddIE5WUk06IFRoZSBOVklESUEgcHJv
YmUgcm91dGluZSBmYWlsZWQgZm9yIDEgZGV2aWNlKHMpLgpbICA1NzAuMjYzMDkzXSBOVlJN
OiBOb25lIG9mIHRoZSBOVklESUEgZGV2aWNlcyB3ZXJlIGluaXRpYWxpemVkLgpbICA1NzAu
MjY0ODUwXSBudmlkaWEtbnZsaW5rOiBVbnJlZ2lzdGVyZWQgTnZsaW5rIENvcmUsIG1ham9y
IGRldmljZSBudW1iZXIgNTA5ClsgIDU3MC44Mjc2NjhdIG52aWRpYS1udmxpbms6IE52bGlu
ayBDb3JlIGlzIGJlaW5nIGluaXRpYWxpemVkLCBtYWpvciBkZXZpY2UgbnVtYmVyIDUwOQpb
ICA1NzAuODI3Njc2XSBOVlJNOiBUaGlzIGlzIGEgNjQtYml0IEJBUiBtYXBwZWQgYWJvdmUg
NEdCIGJ5IHRoZSBzeXN0ZW0KICAgICAgICAgICAgICAgTlZSTTogQklPUyBvciB0aGUgTGlu
dXgga2VybmVsLCBidXQgdGhlIFBDSSBicmlkZ2UKICAgICAgICAgICAgICAgTlZSTTogaW1t
ZWRpYXRlbHkgdXBzdHJlYW0gb2YgdGhpcyBHUFUgZG9lcyBub3QgZGVmaW5lCiAgICAgICAg
ICAgICAgIE5WUk06IGEgbWF0Y2hpbmcgcHJlZmV0Y2hhYmxlIG1lbW9yeSB3aW5kb3cuClsg
IDU3MC45NjY3ODFdIE5WUk06IFRoaXMgbWF5IGJlIGR1ZSB0byBhIGtub3duIExpbnV4IGtl
cm5lbCBidWcuICBQbGVhc2UKICAgICAgICAgICAgICAgTlZSTTogc2VlIHRoZSBSRUFETUUg
c2VjdGlvbiBvbiA2NC1iaXQgQkFScyBmb3IgYWRkaXRpb25hbAogICAgICAgICAgICAgICBO
VlJNOiBpbmZvcm1hdGlvbi4KWyAgNTcwLjk2NjgzMl0gbnZpZGlhOiBwcm9iZSBvZiAwMDAw
OjAyOjAwLjAgZmFpbGVkIHdpdGggZXJyb3IgLTEKWyAgNTcwLjk2Njg4MV0gTlZSTTogVGhl
IE5WSURJQSBwcm9iZSByb3V0aW5lIGZhaWxlZCBmb3IgMSBkZXZpY2UocykuClsgIDU3MC45
NjY4ODRdIE5WUk06IE5vbmUgb2YgdGhlIE5WSURJQSBkZXZpY2VzIHdlcmUgaW5pdGlhbGl6
ZWQuClsgIDU3MC45Njc2NjRdIG52aWRpYS1udmxpbms6IFVucmVnaXN0ZXJlZCBOdmxpbmsg
Q29yZSwgbWFqb3IgZGV2aWNlIG51bWJlciA1MDkK
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="post-upgrade-Ubuntu
 22-04-pcireallocoff.log"
Content-Disposition: attachment; filename="post-upgrade-Ubuntu
 22-04-pcireallocoff.log"
Content-Transfer-Encoding: base64

cGNpPXJlYWxsb2M9b2ZmCi0tLSBPUyAmIEtFUk5FTCAtLS0KRGlzdHJpYnV0b3IgSUQ6CVVi
dW50dQpEZXNjcmlwdGlvbjoJVWJ1bnR1IDIyLjA0LjUgTFRTClJlbGVhc2U6CTIyLjA0CkNv
ZGVuYW1lOglqYW1teQpMaW51eCBseHVzZXItU3dpZnQtU0YzMTQtNTZHIDYuOC4wLTExMC1n
ZW5lcmljICMxMTB+MjIuMDQuMS1VYnVudHUgU01QIFBSRUVNUFRfRFlOQU1JQyBGcmkgTWFy
IDI3IDEyOjQzOjA4IFVUQyAgeDg2XzY0IHg4Nl82NCB4ODZfNjQgR05VL0xpbnV4Ci0tLSBT
RVNTSU9OIFRZUEUgLS0tCngxMQotLS0gSU5TVEFMTEVEIFBBQ0tBR0VTIChOVklESUEvTUVT
QSkgLS0tCmlpICBsaWJkcm0tbm91dmVhdTI6YW1kNjQgICAgICAgICAgICAgICAgICAgICAg
Mi40LjExMy0yfnVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0
ICAgICAgICBVc2Vyc3BhY2UgaW50ZXJmYWNlIHRvIG5vdXZlYXUtc3BlY2lmaWMga2VybmVs
IERSTSBzZXJ2aWNlcyAtLSBydW50aW1lCmlpICBsaWJlZ2wtbWVzYTA6YW1kNjQgICAgICAg
ICAgICAgICAgICAgICAgICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAg
ICAgICAgICAgICAgIGFtZDY0ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBF
R0wgQVBJIC0tIE1lc2EgdmVuZG9yIGxpYnJhcnkKaWkgIGxpYmdsMS1tZXNhLWRyaTphbWQ2
NCAgICAgICAgICAgICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAg
ICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIGZyZWUgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIE9wZW5HTCBBUEkgLS0gRFJJIG1vZHVsZXMKaWkgIGxpYmdsYXBpLW1lc2E6YW1kNjQg
ICAgICAgICAgICAgICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAg
ICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIGZyZWUgaW1wbGVtZW50YXRpb24gb2Yg
dGhlIEdMIEFQSSAtLSBzaGFyZWQgbGlicmFyeQppaSAgbGliZ2x1MS1tZXNhOmFtZDY0ICAg
ICAgICAgICAgICAgICAgICAgICAgIDkuMC4yLTEgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTWVzYSBPcGVuR0wgdXRpbGl0eSBsaWJy
YXJ5IChHTFUpCmlpICBsaWJnbHgtbWVzYTA6YW1kNjQgICAgICAgICAgICAgICAgICAgICAg
ICAgMjMuMi4xLTF1YnVudHUzLjF+MjIuMDQuMyAgICAgICAgICAgICAgICAgICAgICAgIGFt
ZDY0ICAgICAgICBmcmVlIGltcGxlbWVudGF0aW9uIG9mIHRoZSBPcGVuR0wgQVBJIC0tIEdM
WCB2ZW5kb3IgbGlicmFyeQppaSAgbGlibnZpZGlhLWNmZzEtNTcwOmFtZDY0ICAgICAgICAg
ICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAg
ICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGJpbmFyeSBPcGVuR0wvR0xYIGNvbmZpZ3VyYXRp
b24gbGlicmFyeQppaSAgbGlibnZpZGlhLWNvbW1vbi01NzAgICAgICAgICAgICAgICAgICAg
ICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgU2hhcmVkIGZpbGVzIHVzZWQgYnkgdGhlIE5WSURJQSBsaWJyYXJpZXMK
aWkgIGxpYm52aWRpYS1jb21wdXRlLTU3MDphbWQ2NCAgICAgICAgICAgICAgICA1NzAuMjEx
LjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAg
IE5WSURJQSBsaWJjb21wdXRlIHBhY2thZ2UKaWkgIGxpYm52aWRpYS1jb21wdXRlLTU3MDpp
Mzg2ICAgICAgICAgICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAg
ICAgICAgICAgICAgICAgaTM4NiAgICAgICAgIE5WSURJQSBsaWJjb21wdXRlIHBhY2thZ2UK
aWkgIGxpYm52aWRpYS1kZWNvZGUtNTcwOmFtZDY0ICAgICAgICAgICAgICAgICA1NzAuMjEx
LjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAg
IE5WSURJQSBWaWRlbyBEZWNvZGluZyBydW50aW1lIGxpYnJhcmllcwppaSAgbGlibnZpZGlh
LWRlY29kZS01NzA6aTM4NiAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAu
MjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZJRElBIFZpZGVv
IERlY29kaW5nIHJ1bnRpbWUgbGlicmFyaWVzCmlpICBsaWJudmlkaWEtZWdsLXdheWxhbmQx
OmFtZDY0ICAgICAgICAgICAgICAgMToxLjEuOS0xLjF1YnVudHUwLjEgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBXYXlsYW5kIEVHTCBFeHRlcm5hbCBQbGF0
Zm9ybSBsaWJyYXJ5IC0tIHNoYXJlZCBsaWJyYXJ5CmlpICBsaWJudmlkaWEtZW5jb2RlLTU3
MDphbWQ2NCAgICAgICAgICAgICAgICAgNTcwLjIxMS4wMS0wdWJ1bnR1MC4yMi4wNC4xICAg
ICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBOVkVOQyBWaWRlbyBFbmNvZGluZyBy
dW50aW1lIGxpYnJhcnkKaWkgIGxpYm52aWRpYS1lbmNvZGUtNTcwOmkzODYgICAgICAgICAg
ICAgICAgICA1NzAuMjExLjAxLTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAg
ICAgaTM4NiAgICAgICAgIE5WRU5DIFZpZGVvIEVuY29kaW5nIHJ1bnRpbWUgbGlicmFyeQpp
aSAgbGlibnZpZGlhLWV4dHJhLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgIDU3MC4yMTEu
MDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAg
RXh0cmEgbGlicmFyaWVzIGZvciB0aGUgTlZJRElBIGRyaXZlcgppaSAgbGlibnZpZGlhLWZi
YzEtNTcwOmFtZDY0ICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIu
MDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIE9wZW5HTC1i
YXNlZCBGcmFtZWJ1ZmZlciBDYXB0dXJlIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZpZGlh
LWZiYzEtNTcwOmkzODYgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAu
MjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBpMzg2ICAgICAgICAgTlZJRElBIE9wZW5H
TC1iYXNlZCBGcmFtZWJ1ZmZlciBDYXB0dXJlIHJ1bnRpbWUgbGlicmFyeQppaSAgbGlibnZp
ZGlhLWdsLTU3MDphbWQ2NCAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50
dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIE9w
ZW5HTC9HTFgvRUdML0dMRVMgR0xWTkQgbGlicmFyaWVzIGFuZCBWdWxrYW4gSUNECmlpICBt
ZXNhLXV0aWxzICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOC40LjAtMXVidW50
dTEgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNaXNj
ZWxsYW5lb3VzIE1lc2EgdXRpbGl0aWVzIC0tIHN5bWxpbmtzCmlpICBtZXNhLXV0aWxzLWJp
bjphbWQ2NCAgICAgICAgICAgICAgICAgICAgICAgOC40LjAtMXVidW50dTEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAgICBNaXNjZWxsYW5lb3VzIE1l
c2EgdXRpbGl0aWVzIC0tIG5hdGl2ZSBhcHBsaWNhdGlvbnMKaWkgIG1lc2EtdmRwYXUtZHJp
dmVyczphbWQ2NCAgICAgICAgICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4z
ICAgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE1lc2EgVkRQQVUgdmlkZW8g
YWNjZWxlcmF0aW9uIGRyaXZlcnMKaWkgIG1lc2EtdnVsa2FuLWRyaXZlcnM6YW1kNjQgICAg
ICAgICAgICAgICAgICAyMy4yLjEtMXVidW50dTMuMX4yMi4wNC4zICAgICAgICAgICAgICAg
ICAgICAgICAgYW1kNjQgICAgICAgIE1lc2EgVnVsa2FuIGdyYXBoaWNzIGRyaXZlcnMKaWkg
IG52aWRpYS1jb21wdXRlLXV0aWxzLTU3MCAgICAgICAgICAgICAgICAgICA1NzAuMjExLjAx
LTB1YnVudHUwLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgYW1kNjQgICAgICAgIE5W
SURJQSBjb21wdXRlIHV0aWxpdGllcwppaSAgbnZpZGlhLWRrbXMtNTcwICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAg
ICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIERLTVMgcGFja2FnZQppaSAgbnZpZGlh
LWRyaXZlci01NzAgICAgICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50
dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElBIGRy
aXZlciBtZXRhcGFja2FnZQppaSAgbnZpZGlhLWZpcm13YXJlLTU3MC01NzAuMjExLjAxICAg
ICAgICAgICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAg
ICAgICBhbWQ2NCAgICAgICAgRmlybXdhcmUgZmlsZXMgdXNlZCBieSB0aGUga2VybmVsIG1v
ZHVsZQppaSAgbnZpZGlhLWtlcm5lbC1jb21tb24tNTcwICAgICAgICAgICAgICAgICAgIDU3
MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAg
ICAgICAgU2hhcmVkIGZpbGVzIHVzZWQgd2l0aCB0aGUga2VybmVsIG1vZHVsZQppaSAgbnZp
ZGlhLWtlcm5lbC1zb3VyY2UtNTcwICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEtMHVi
dW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJRElB
IGtlcm5lbCBzb3VyY2UgcGFja2FnZQppaSAgbnZpZGlhLXByaW1lICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIDAuOC4xNy4xICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhbGwgICAgICAgICAgVG9vbHMgdG8gZW5hYmxlIE5WSURJQSdzIFByaW1l
CmlpICBudmlkaWEtc2V0dGluZ3MgICAgICAgICAgICAgICAgICAgICAgICAgICAgNTEwLjQ3
LjAzLTB1YnVudHUxLjIyLjA0LjEgICAgICAgICAgICAgICAgICAgICAgIGFtZDY0ICAgICAg
ICBUb29sIGZvciBjb25maWd1cmluZyB0aGUgTlZJRElBIGdyYXBoaWNzIGRyaXZlcgppaSAg
bnZpZGlhLXV0aWxzLTU3MCAgICAgICAgICAgICAgICAgICAgICAgICAgIDU3MC4yMTEuMDEt
MHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBhbWQ2NCAgICAgICAgTlZJ
RElBIGRyaXZlciBzdXBwb3J0IGJpbmFyaWVzCmlpICBzY3JlZW4tcmVzb2x1dGlvbi1leHRy
YSAgICAgICAgICAgICAgICAgICAgMC4xOC4ydWJ1bnR1MC4xICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGFsbCAgICAgICAgICBFeHRlbnNpb24gZm9yIHRoZSBudmlkaWEt
c2V0dGluZ3MgY29udHJvbCBwYW5lbAppaSAgeHNlcnZlci14b3JnLXZpZGVvLW5vdXZlYXUg
ICAgICAgICAgICAgICAgIDE6MS4wLjE3LTJidWlsZDEgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBhbWQ2NCAgICAgICAgWC5PcmcgWCBzZXJ2ZXIgLS0gTm91dmVhdSBkaXNw
bGF5IGRyaXZlcgppaSAgeHNlcnZlci14b3JnLXZpZGVvLW52aWRpYS01NzAgICAgICAgICAg
ICAgIDU3MC4yMTEuMDEtMHVidW50dTAuMjIuMDQuMSAgICAgICAgICAgICAgICAgICAgICBh
bWQ2NCAgICAgICAgTlZJRElBIGJpbmFyeSBYb3JnIGRyaXZlcgotLS0gUENJIERSSVZFUiBT
VEFUVVMgLS0tCjAwOjAyLjAgVkdBIGNvbXBhdGlibGUgY29udHJvbGxlcjogSW50ZWwgQ29y
cG9yYXRpb24gV2hpc2tleUxha2UtVSBHVDIgW1VIRCBHcmFwaGljcyA2MjBdCglTdWJzeXN0
ZW06IEFjZXIgSW5jb3Jwb3JhdGVkIFtBTEldIFdoaXNrZXlMYWtlLVUgR1QyIFtVSEQgR3Jh
cGhpY3MgNjIwXQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGk5MTUKLS0KMDI6MDAuMCAzRCBj
b250cm9sbGVyOiBOVklESUEgQ29ycG9yYXRpb24gR1AxMDhNIFtHZUZvcmNlIE1YMjUwXSAo
cmV2IGZmKQoJS2VybmVsIG1vZHVsZXM6IG52aWRpYWZiLCBub3V2ZWF1LCBudmlkaWFfZHJt
LCBudmlkaWEKMDQ6MDAuMCBOb24tVm9sYXRpbGUgbWVtb3J5IGNvbnRyb2xsZXI6IE1pY3Jv
bi9DcnVjaWFsIFRlY2hub2xvZ3kgUDEgTlZNZSBQQ0llIFNTRCAocmV2IDAzKQotLS0gR1BV
IFJFTkRFUkVSIC0tLQotLS0gTlZJRElBLVNNSSAtLS0KTlZJRElBLVNNSSBoYXMgZmFpbGVk
IGJlY2F1c2UgaXQgY291bGRuJ3QgY29tbXVuaWNhdGUgd2l0aCB0aGUgTlZJRElBIGRyaXZl
ci4gTWFrZSBzdXJlIHRoYXQgdGhlIGxhdGVzdCBOVklESUEgZHJpdmVyIGlzIGluc3RhbGxl
ZCBhbmQgcnVubmluZy4KCi0tLSBQT1dFUiBNQU5BR0VNRU5UIC0tLQpDb250cm9sOiBhdXRv
ClN0YXR1czogc3VzcGVuZGVkCi0tLSBMQVNUIDIwIFBDSS9OVklESUEgTE9HUyAtLS0KICAg
ICAgICAgICAgICAgTlZSTTogYSBtYXRjaGluZyBwcmVmZXRjaGFibGUgbWVtb3J5IHdpbmRv
dy4KWyAgNjY1LjY1NDYzNl0gTlZSTTogVGhpcyBtYXkgYmUgZHVlIHRvIGEga25vd24gTGlu
dXgga2VybmVsIGJ1Zy4gIFBsZWFzZQogICAgICAgICAgICAgICBOVlJNOiBzZWUgdGhlIFJF
QURNRSBzZWN0aW9uIG9uIDY0LWJpdCBCQVJzIGZvciBhZGRpdGlvbmFsCiAgICAgICAgICAg
ICAgIE5WUk06IGluZm9ybWF0aW9uLgpbICA2NjUuNjU0Njk5XSBudmlkaWE6IHByb2JlIG9m
IDAwMDA6MDI6MDAuMCBmYWlsZWQgd2l0aCBlcnJvciAtMQpbICA2NjUuNjU0ODI4XSBOVlJN
OiBUaGUgTlZJRElBIHByb2JlIHJvdXRpbmUgZmFpbGVkIGZvciAxIGRldmljZShzKS4KWyAg
NjY1LjY1NDgzNV0gTlZSTTogTm9uZSBvZiB0aGUgTlZJRElBIGRldmljZXMgd2VyZSBpbml0
aWFsaXplZC4KWyAgNjY1LjY1NjU4MF0gbnZpZGlhLW52bGluazogVW5yZWdpc3RlcmVkIE52
bGluayBDb3JlLCBtYWpvciBkZXZpY2UgbnVtYmVyIDUwOQpbICA2NjYuMTg3NTEwXSBudmlk
aWEtbnZsaW5rOiBOdmxpbmsgQ29yZSBpcyBiZWluZyBpbml0aWFsaXplZCwgbWFqb3IgZGV2
aWNlIG51bWJlciA1MDkKWyAgNjY2LjE4NzUxOV0gTlZSTTogVGhpcyBpcyBhIDY0LWJpdCBC
QVIgbWFwcGVkIGFib3ZlIDRHQiBieSB0aGUgc3lzdGVtCiAgICAgICAgICAgICAgIE5WUk06
IEJJT1Mgb3IgdGhlIExpbnV4IGtlcm5lbCwgYnV0IHRoZSBQQ0kgYnJpZGdlCiAgICAgICAg
ICAgICAgIE5WUk06IGltbWVkaWF0ZWx5IHVwc3RyZWFtIG9mIHRoaXMgR1BVIGRvZXMgbm90
IGRlZmluZQogICAgICAgICAgICAgICBOVlJNOiBhIG1hdGNoaW5nIHByZWZldGNoYWJsZSBt
ZW1vcnkgd2luZG93LgpbICA2NjYuMzI2NTk2XSBOVlJNOiBUaGlzIG1heSBiZSBkdWUgdG8g
YSBrbm93biBMaW51eCBrZXJuZWwgYnVnLiAgUGxlYXNlCiAgICAgICAgICAgICAgIE5WUk06
IHNlZSB0aGUgUkVBRE1FIHNlY3Rpb24gb24gNjQtYml0IEJBUnMgZm9yIGFkZGl0aW9uYWwK
ICAgICAgICAgICAgICAgTlZSTTogaW5mb3JtYXRpb24uClsgIDY2Ni4zMjY2NjBdIG52aWRp
YTogcHJvYmUgb2YgMDAwMDowMjowMC4wIGZhaWxlZCB3aXRoIGVycm9yIC0xClsgIDY2Ni4z
MjY3MzVdIE5WUk06IFRoZSBOVklESUEgcHJvYmUgcm91dGluZSBmYWlsZWQgZm9yIDEgZGV2
aWNlKHMpLgpbICA2NjYuMzI2NzM5XSBOVlJNOiBOb25lIG9mIHRoZSBOVklESUEgZGV2aWNl
cyB3ZXJlIGluaXRpYWxpemVkLgpbICA2NjYuMzI4MTMzXSBudmlkaWEtbnZsaW5rOiBVbnJl
Z2lzdGVyZWQgTnZsaW5rIENvcmUsIG1ham9yIGRldmljZSBudW1iZXIgNTA5Cg==
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="Skript"
Content-Disposition: attachment; filename="Skript"
Content-Transfer-Encoding: base64

ewogIGVjaG8gIi0tLSBPUyAmIEtFUk5FTCAtLS0iCiAgY2F0IC9wcm9jL2NtZGxpbmUKICBs
c2JfcmVsZWFzZSAtYQogIHVuYW1lIC1hCiAgZWNobyAiLS0tIFNFU1NJT04gVFlQRSAtLS0i
CiAgZWNobyAkWERHX1NFU1NJT05fVFlQRQogIGVjaG8gIi0tLSBJTlNUQUxMRUQgUEFDS0FH
RVMgKE5WSURJQS9NRVNBKSAtLS0iCiAgZHBrZyAtbCB8IGdyZXAgLUUgIihudmlkaWF8bm91
dmVhdXxtZXNhKSIKICBlY2hvICItLS0gUENJIERSSVZFUiBTVEFUVVMgLS0tIgogIGxzcGNp
IC1rIHwgZ3JlcCAtQSAyIC1FICIoVkdBfDNEKSIKICBlY2hvICItLS0gR1BVIFJFTkRFUkVS
IC0tLSIKICBfX05WX1BSSU1FX1JFTkRFUl9PRkZMT0FEPTEgX19HTFhfVkVORE9SX0xJQlJB
UllfTkFNRT1udmlkaWEgZ2x4aW5mbyAtQiB8IGdyZXAgLWkgInJlbmRlcmVyIgogIGVjaG8g
Ii0tLSBOVklESUEtU01JIC0tLSIKICBudmlkaWEtc21pCiAgZWNobyAiLS0tIFBPV0VSIE1B
TkFHRU1FTlQgLS0tIgogIGVjaG8gLW4gIkNvbnRyb2w6ICIgJiYgY2F0IC9zeXMvYnVzL3Bj
aS9kZXZpY2VzLzAwMDA6MDI6MDAuMC9wb3dlci9jb250cm9sCiAgZWNobyAtbiAiU3RhdHVz
OiAiICYmIGNhdCAvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwOjAyOjAwLjAvcG93ZXIvcnVu
dGltZV9zdGF0dXMKICBlY2hvICItLS0gTEFTVCAyMCBQQ0kvTlZJRElBIExPR1MgLS0tIgog
IHN1ZG8gZG1lc2cgfCBncmVwIC1pRSAicGNpIDAwMDA6MDI6MDAuMHxudnJtfG52aWRpYSIg
fCB0YWlsIC1uIDIwCn0gPiB+L3Bvc3QtdXBncmFkZS0yMjA0LTMyQml0LmxvZwo=
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="Nuveau-Ubuntu 20.04"
Content-Disposition: attachment; filename="Nuveau-Ubuntu 20.04"
Content-Transfer-Encoding: base64

Z2xtYXJrMgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CiAgICBnbG1hcmsyIDIwMjEuMDIKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgT3BlbkdMIEluZm9ybWF0aW9u
CiAgICBHTF9WRU5ET1I6ICAgICBJbnRlbAogICAgR0xfUkVOREVSRVI6ICAgTWVzYSBJbnRl
bChSKSBVSEQgR3JhcGhpY3MgNjIwIChXSEwgR1QyKQogICAgR0xfVkVSU0lPTjogICAgNC42
IChDb21wYXRpYmlsaXR5IFByb2ZpbGUpIE1lc2EgMjEuMi42Cj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KW2J1aWxkXSB1c2UtdmJv
PWZhbHNlOiBGUFM6IDI1MjUgRnJhbWVUaW1lOiAwLjM5NiBtcwpbYnVpbGRdIHVzZS12Ym89
dHJ1ZTogRlBTOiAzMzQ0IEZyYW1lVGltZTogMC4yOTkgbXMKW3RleHR1cmVdIHRleHR1cmUt
ZmlsdGVyPW5lYXJlc3Q6IEZQUzogMjk2OCBGcmFtZVRpbWU6IDAuMzM3IG1zClt0ZXh0dXJl
XSB0ZXh0dXJlLWZpbHRlcj1saW5lYXI6IEZQUzogMjkxNSBGcmFtZVRpbWU6IDAuMzQzIG1z
Clt0ZXh0dXJlXSB0ZXh0dXJlLWZpbHRlcj1taXBtYXA6IEZQUzogMjk0MCBGcmFtZVRpbWU6
IDAuMzQwIG1zCltzaGFkaW5nXSBzaGFkaW5nPWdvdXJhdWQ6IEZQUzogMjYzMCBGcmFtZVRp
bWU6IDAuMzgwIG1zCltzaGFkaW5nXSBzaGFkaW5nPWJsaW5uLXBob25nLWluZjogRlBTOiAy
NTMzIEZyYW1lVGltZTogMC4zOTUgbXMKW3NoYWRpbmddIHNoYWRpbmc9cGhvbmc6IEZQUzog
MjEwOCBGcmFtZVRpbWU6IDAuNDc0IG1zCltzaGFkaW5nXSBzaGFkaW5nPWNlbDogRlBTOiAy
MzIyIEZyYW1lVGltZTogMC40MzEgbXMKW2J1bXBdIGJ1bXAtcmVuZGVyPWhpZ2gtcG9seTog
RlBTOiAxNzcwIEZyYW1lVGltZTogMC41NjUgbXMKW2J1bXBdIGJ1bXAtcmVuZGVyPW5vcm1h
bHM6IEZQUzogMzM1NCBGcmFtZVRpbWU6IDAuMjk4IG1zCltidW1wXSBidW1wLXJlbmRlcj1o
ZWlnaHQ6IEZQUzogMzIwMSBGcmFtZVRpbWU6IDAuMzEyIG1zCltlZmZlY3QyZF0ga2VybmVs
PTAsMSwwOzEsLTQsMTswLDEsMDs6IEZQUzogMTk4MyBGcmFtZVRpbWU6IDAuNTA0IG1zCltl
ZmZlY3QyZF0ga2VybmVsPTEsMSwxLDEsMTsxLDEsMSwxLDE7MSwxLDEsMSwxOzogRlBTOiAx
MTMyIEZyYW1lVGltZTogMC44ODMgbXMKW3B1bHNhcl0gbGlnaHQ9ZmFsc2U6cXVhZHM9NTp0
ZXh0dXJlPWZhbHNlOiBGUFM6IDI4NjYgRnJhbWVUaW1lOiAwLjM0OSBtcwpbZGVza3RvcF0g
Ymx1ci1yYWRpdXM9NTplZmZlY3Q9Ymx1cjpwYXNzZXM9MTpzZXBhcmFibGU9dHJ1ZTp3aW5k
b3dzPTQ6IEZQUzogMTA1NiBGcmFtZVRpbWU6IDAuOTQ3IG1zCltkZXNrdG9wXSBlZmZlY3Q9
c2hhZG93OndpbmRvd3M9NDogRlBTOiAxNzQ1IEZyYW1lVGltZTogMC41NzMgbXMKW2J1ZmZl
cl0gY29sdW1ucz0yMDA6aW50ZXJsZWF2ZT1mYWxzZTp1cGRhdGUtZGlzcGVyc2lvbj0wLjk6
dXBkYXRlLWZyYWN0aW9uPTAuNTp1cGRhdGUtbWV0aG9kPW1hcDogRlBTOiA4MTMgRnJhbWVU
aW1lOiAxLjIzMCBtcwpbYnVmZmVyXSBjb2x1bW5zPTIwMDppbnRlcmxlYXZlPWZhbHNlOnVw
ZGF0ZS1kaXNwZXJzaW9uPTAuOTp1cGRhdGUtZnJhY3Rpb249MC41OnVwZGF0ZS1tZXRob2Q9
c3ViZGF0YTogRlBTOiA3NzMgRnJhbWVUaW1lOiAxLjI5NCBtcwpbYnVmZmVyXSBjb2x1bW5z
PTIwMDppbnRlcmxlYXZlPXRydWU6dXBkYXRlLWRpc3BlcnNpb249MC45OnVwZGF0ZS1mcmFj
dGlvbj0wLjU6dXBkYXRlLW1ldGhvZD1tYXA6IEZQUzogOTE1IEZyYW1lVGltZTogMS4wOTMg
bXMKW2lkZWFzXSBzcGVlZD1kdXJhdGlvbjogRlBTOiAyMzk4IEZyYW1lVGltZTogMC40MTcg
bXMKW2plbGx5ZmlzaF0gPGRlZmF1bHQ+OiBGUFM6IDE5MjIgRnJhbWVUaW1lOiAwLjUyMCBt
cwpbdGVycmFpbl0gPGRlZmF1bHQ+OiBGUFM6IDI0MCBGcmFtZVRpbWU6IDQuMTY3IG1zCltz
aGFkb3ddIDxkZWZhdWx0PjogRlBTOiAxODAxIEZyYW1lVGltZTogMC41NTUgbXMKW3JlZnJh
Y3RdIDxkZWZhdWx0PjogRlBTOiA0NzYgRnJhbWVUaW1lOiAyLjEwMSBtcwpbY29uZGl0aW9u
YWxzXSBmcmFnbWVudC1zdGVwcz0wOnZlcnRleC1zdGVwcz0wOiBGUFM6IDI0NzkgRnJhbWVU
aW1lOiAwLjQwMyBtcwpbY29uZGl0aW9uYWxzXSBmcmFnbWVudC1zdGVwcz01OnZlcnRleC1z
dGVwcz0wOiBGUFM6IDI0OTEgRnJhbWVUaW1lOiAwLjQwMSBtcwpbY29uZGl0aW9uYWxzXSBm
cmFnbWVudC1zdGVwcz0wOnZlcnRleC1zdGVwcz01OiBGUFM6IDI0ODEgRnJhbWVUaW1lOiAw
LjQwMyBtcwpbZnVuY3Rpb25dIGZyYWdtZW50LWNvbXBsZXhpdHk9bG93OmZyYWdtZW50LXN0
ZXBzPTU6IEZQUzogMjQ4NiBGcmFtZVRpbWU6IDAuNDAyIG1zCltmdW5jdGlvbl0gZnJhZ21l
bnQtY29tcGxleGl0eT1tZWRpdW06ZnJhZ21lbnQtc3RlcHM9NTogRlBTOiAyNTA1IEZyYW1l
VGltZTogMC4zOTkgbXMKW2xvb3BdIGZyYWdtZW50LWxvb3A9ZmFsc2U6ZnJhZ21lbnQtc3Rl
cHM9NTp2ZXJ0ZXgtc3RlcHM9NTogRlBTOiAyNDg4IEZyYW1lVGltZTogMC40MDIgbXMKW2xv
b3BdIGZyYWdtZW50LXN0ZXBzPTU6ZnJhZ21lbnQtdW5pZm9ybT1mYWxzZTp2ZXJ0ZXgtc3Rl
cHM9NTogRlBTOiAyNDk2IEZyYW1lVGltZTogMC40MDEgbXMKW2xvb3BdIGZyYWdtZW50LXN0
ZXBzPTU6ZnJhZ21lbnQtdW5pZm9ybT10cnVlOnZlcnRleC1zdGVwcz01OiBGUFM6IDI1MDUg
RnJhbWVUaW1lOiAwLjM5OSBtcwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBnbG1hcmsyIFNjb3JlOiAyMTQxIAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Cmx4dXNlckBseHVzZXItU3dpZnQtU0YzMTQtNTZH
On4kIERSSV9QUklNRT0xIGdsbWFyazIKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgZ2xtYXJrMiAyMDIxLjAyCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KICAgIE9w
ZW5HTCBJbmZvcm1hdGlvbgogICAgR0xfVkVORE9SOiAgICAgbm91dmVhdQogICAgR0xfUkVO
REVSRVI6ICAgTlYxMzgKICAgIEdMX1ZFUlNJT046ICAgIDQuMyAoQ29tcGF0aWJpbGl0eSBQ
cm9maWxlKSBNZXNhIDIxLjIuNgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09CltidWlsZF0gdXNlLXZibz1mYWxzZTogRlBTOiAyNjgg
RnJhbWVUaW1lOiAzLjczMSBtcwpbYnVpbGRdIHVzZS12Ym89dHJ1ZTogRlBTOiAyODggRnJh
bWVUaW1lOiAzLjQ3MiBtcwpbdGV4dHVyZV0gdGV4dHVyZS1maWx0ZXI9bmVhcmVzdDogRlBT
OiAyNTkgRnJhbWVUaW1lOiAzLjg2MSBtcwpbdGV4dHVyZV0gdGV4dHVyZS1maWx0ZXI9bGlu
ZWFyOiBGUFM6IDI1OCBGcmFtZVRpbWU6IDMuODc2IG1zClt0ZXh0dXJlXSB0ZXh0dXJlLWZp
bHRlcj1taXBtYXA6IEZQUzogMjY1IEZyYW1lVGltZTogMy43NzQgbXMKW3NoYWRpbmddIHNo
YWRpbmc9Z291cmF1ZDogRlBTOiAyNjYgRnJhbWVUaW1lOiAzLjc1OSBtcwpbc2hhZGluZ10g
c2hhZGluZz1ibGlubi1waG9uZy1pbmY6IEZQUzogMjY2IEZyYW1lVGltZTogMy43NTkgbXMK
W3NoYWRpbmddIHNoYWRpbmc9cGhvbmc6IEZQUzogMjY2IEZyYW1lVGltZTogMy43NTkgbXMK
W3NoYWRpbmddIHNoYWRpbmc9Y2VsOiBGUFM6IDI2NSBGcmFtZVRpbWU6IDMuNzc0IG1zClti
dW1wXSBidW1wLXJlbmRlcj1oaWdoLXBvbHk6IEZQUzogMjQ1IEZyYW1lVGltZTogNC4wODIg
bXMKW2J1bXBdIGJ1bXAtcmVuZGVyPW5vcm1hbHM6IEZQUzogMjg0IEZyYW1lVGltZTogMy41
MjEgbXMKW2J1bXBdIGJ1bXAtcmVuZGVyPWhlaWdodDogRlBTOiAyODggRnJhbWVUaW1lOiAz
LjQ3MiBtcwpbZWZmZWN0MmRdIGtlcm5lbD0wLDEsMDsxLC00LDE7MCwxLDA7OiBGUFM6IDIy
NiBGcmFtZVRpbWU6IDQuNDI1IG1zCltlZmZlY3QyZF0ga2VybmVsPTEsMSwxLDEsMTsxLDEs
MSwxLDE7MSwxLDEsMSwxOzogRlBTOiAyMTkgRnJhbWVUaW1lOiA0LjU2NiBtcwpbcHVsc2Fy
XSBsaWdodD1mYWxzZTpxdWFkcz01OnRleHR1cmU9ZmFsc2U6IEZQUzogMjM1IEZyYW1lVGlt
ZTogNC4yNTUgbXMKW2Rlc2t0b3BdIGJsdXItcmFkaXVzPTU6ZWZmZWN0PWJsdXI6cGFzc2Vz
PTE6c2VwYXJhYmxlPXRydWU6d2luZG93cz00OiBGUFM6IDE4NyBGcmFtZVRpbWU6IDUuMzQ4
IG1zCltkZXNrdG9wXSBlZmZlY3Q9c2hhZG93OndpbmRvd3M9NDogRlBTOiAxOTkgRnJhbWVU
aW1lOiA1LjAyNSBtcwpbYnVmZmVyXSBjb2x1bW5zPTIwMDppbnRlcmxlYXZlPWZhbHNlOnVw
ZGF0ZS1kaXNwZXJzaW9uPTAuOTp1cGRhdGUtZnJhY3Rpb249MC41OnVwZGF0ZS1tZXRob2Q9
bWFwOiBGUFM6IDE5NCBGcmFtZVRpbWU6IDUuMTU1IG1zCltidWZmZXJdIGNvbHVtbnM9MjAw
OmludGVybGVhdmU9ZmFsc2U6dXBkYXRlLWRpc3BlcnNpb249MC45OnVwZGF0ZS1mcmFjdGlv
bj0wLjU6dXBkYXRlLW1ldGhvZD1zdWJkYXRhOiBGUFM6IDIxOSBGcmFtZVRpbWU6IDQuNTY2
IG1zCltidWZmZXJdIGNvbHVtbnM9MjAwOmludGVybGVhdmU9dHJ1ZTp1cGRhdGUtZGlzcGVy
c2lvbj0wLjk6dXBkYXRlLWZyYWN0aW9uPTAuNTp1cGRhdGUtbWV0aG9kPW1hcDogRlBTOiAx
OTUgRnJhbWVUaW1lOiA1LjEyOCBtcwpbaWRlYXNdIHNwZWVkPWR1cmF0aW9uOiBGUFM6IDI4
MCBGcmFtZVRpbWU6IDMuNTcxIG1zCltqZWxseWZpc2hdIDxkZWZhdWx0PjogRlBTOiAyMzUg
RnJhbWVUaW1lOiA0LjI1NSBtcwpbdGVycmFpbl0gPGRlZmF1bHQ+OiBGUFM6IDU4IEZyYW1l
VGltZTogMTcuMjQxIG1zCltzaGFkb3ddIDxkZWZhdWx0PjogRlBTOiAxOTAgRnJhbWVUaW1l
OiA1LjI2MyBtcwpbcmVmcmFjdF0gPGRlZmF1bHQ+OiBGUFM6IDcyIEZyYW1lVGltZTogMTMu
ODg5IG1zCltjb25kaXRpb25hbHNdIGZyYWdtZW50LXN0ZXBzPTA6dmVydGV4LXN0ZXBzPTA6
IEZQUzogMjY3IEZyYW1lVGltZTogMy43NDUgbXMKW2NvbmRpdGlvbmFsc10gZnJhZ21lbnQt
c3RlcHM9NTp2ZXJ0ZXgtc3RlcHM9MDogRlBTOiAyNjcgRnJhbWVUaW1lOiAzLjc0NSBtcwpb
Y29uZGl0aW9uYWxzXSBmcmFnbWVudC1zdGVwcz0wOnZlcnRleC1zdGVwcz01OiBGUFM6IDI2
NyBGcmFtZVRpbWU6IDMuNzQ1IG1zCltmdW5jdGlvbl0gZnJhZ21lbnQtY29tcGxleGl0eT1s
b3c6ZnJhZ21lbnQtc3RlcHM9NTogRlBTOiAyNjcgRnJhbWVUaW1lOiAzLjc0NSBtcwpbZnVu
Y3Rpb25dIGZyYWdtZW50LWNvbXBsZXhpdHk9bWVkaXVtOmZyYWdtZW50LXN0ZXBzPTU6IEZQ
UzogMjY3IEZyYW1lVGltZTogMy43NDUgbXMKW2xvb3BdIGZyYWdtZW50LWxvb3A9ZmFsc2U6
ZnJhZ21lbnQtc3RlcHM9NTp2ZXJ0ZXgtc3RlcHM9NTogRlBTOiAyNjcgRnJhbWVUaW1lOiAz
Ljc0NSBtcwpbbG9vcF0gZnJhZ21lbnQtc3RlcHM9NTpmcmFnbWVudC11bmlmb3JtPWZhbHNl
OnZlcnRleC1zdGVwcz01OiBGUFM6IDI2NyBGcmFtZVRpbWU6IDMuNzQ1IG1zCltsb29wXSBm
cmFnbWVudC1zdGVwcz01OmZyYWdtZW50LXVuaWZvcm09dHJ1ZTp2ZXJ0ZXgtc3RlcHM9NTog
RlBTOiAyNjkgRnJhbWVUaW1lOiAzLjcxNyBtcwo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBnbG1hcmsyIFNjb3JlOiAyMzggCj09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCgpnbHhpbmZvIC1CIHwgZ3JlcCAt
aSAicmVuZGVyZXIiCkV4dGVuZGVkIHJlbmRlcmVyIGluZm8gKEdMWF9NRVNBX3F1ZXJ5X3Jl
bmRlcmVyKToKT3BlbkdMIHJlbmRlcmVyIHN0cmluZzogTWVzYSBJbnRlbChSKSBVSEQgR3Jh
cGhpY3MgNjIwIChXSEwgR1QyKQoKbHh1c2VyQGx4dXNlci1Td2lmdC1TRjMxNC01Nkc6fiQg
RFJJX1BSSU1FPTEgZ2x4aW5mbyAtQiB8IGdyZXAgInJlbmRlcmVyIgpFeHRlbmRlZCByZW5k
ZXJlciBpbmZvIChHTFhfTUVTQV9xdWVyeV9yZW5kZXJlcik6Cgpsc3BjaSAtayB8IGdyZXAg
LUEgMiAtRSAiKFZHQXwzRCkiCgowMDowMi4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6
IEludGVsIENvcnBvcmF0aW9uIFVIRCBHcmFwaGljcyA2MjAgKFdoaXNrZXkgTGFrZSkKCVN1
YnN5c3RlbTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gVUhEIEdyYXBoaWNzIDYyMCAoV2hp
c2tleSBMYWtlKQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGk5MTUKLS0KMDI6MDAuMCAzRCBj
b250cm9sbGVyOiBOVklESUEgQ29ycG9yYXRpb24gR1AxMDhNIFtHZUZvcmNlIE1YMjUwXSAo
cmV2IGExKQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBHUDEwOE0gW0dl
Rm9yY2UgTVgyNTBdCglLZXJuZWwgZHJpdmVyIGluIHVzZTogbm91dmVhdQoKc3VkbyBkbWVz
ZyB8IGdyZXAgLWlFICJub3V2ZWF1fHBjaSAwMDAwOjAyOjAwLjAiCltzdWRvXSBQYXNzd29y
dCBmw7xyIGx4dXNlcjogClsgICAgMC41ODMwNjRdIHBjaSAwMDAwOjAyOjAwLjA6IFsxMGRl
OjFkMTNdIHR5cGUgMDAgY2xhc3MgMHgwMzAyMDAKWyAgICAwLjU4MzA4OV0gcGNpIDAwMDA6
MDI6MDAuMDogcmVnIDB4MTA6IFttZW0gMHhhMzAwMDAwMC0weGEzZmZmZmZmXQpbICAgIDAu
NTgzMTA4XSBwY2kgMDAwMDowMjowMC4wOiByZWcgMHgxNDogW21lbSAweDkwMDAwMDAwLTB4
OWZmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU4MzE0M10gcGNpIDAwMDA6MDI6MDAuMDog
cmVnIDB4MWM6IFttZW0gMHhhMDAwMDAwMC0weGExZmZmZmZmIDY0Yml0IHByZWZdClsgICAg
MC41ODMxNjJdIHBjaSAwMDAwOjAyOjAwLjA6IHJlZyAweDI0OiBbaW8gIDB4MzAwMC0weDMw
N2ZdClsgICAgMC41ODMxNzZdIHBjaSAwMDAwOjAyOjAwLjA6IHJlZyAweDMwOiBbbWVtIDB4
ZmZmODAwMDAtMHhmZmZmZmZmZiBwcmVmXQpbICAgIDAuNTgzMjEyXSBwY2kgMDAwMDowMjow
MC4wOiBFbmFibGluZyBIREEgY29udHJvbGxlcgpbICAgIDAuNzEyMTU0XSBwY2kgMDAwMDow
MjowMC4wOiBjYW4ndCBjbGFpbSBCQVIgNiBbbWVtIDB4ZmZmODAwMDAtMHhmZmZmZmZmZiBw
cmVmXTogbm8gY29tcGF0aWJsZSBicmlkZ2Ugd2luZG93ClsgICAgMC43MTI1ODhdIHBjaSAw
MDAwOjAyOjAwLjA6IEJBUiA2OiBubyBzcGFjZSBmb3IgW21lbSBzaXplIDB4MDAwODAwMDAg
cHJlZl0KWyAgICAwLjcxMjU5MV0gcGNpIDAwMDA6MDI6MDAuMDogQkFSIDY6IGZhaWxlZCB0
byBhc3NpZ24gW21lbSBzaXplIDB4MDAwODAwMDAgcHJlZl0KWyAgIDMxLjkyMzI2OF0gcGNp
IDAwMDA6MDI6MDAuMDogb3B0aW11cyBjYXBhYmlsaXRpZXM6IGVuYWJsZWQsIHN0YXR1cyBk
eW5hbWljIHBvd2VyLCBoZGEgYmlvcyBjb2RlYyBzdXBwb3J0ZWQKWyAgIDMxLjkyMzI3M10g
bm91dmVhdTogZGV0ZWN0ZWQgUFIgc3VwcG9ydCwgd2lsbCBub3QgdXNlIERTTQpbICAgMzEu
OTIzMzAxXSBub3V2ZWF1IDAwMDA6MDI6MDAuMDogZW5hYmxpbmcgZGV2aWNlICgwMTA2IC0+
IDAxMDcpClsgICAzMS45MjM2ODJdIG5vdXZlYXUgMDAwMDowMjowMC4wOiBOVklESUEgR1Ax
MDggKDEzODAwMGExKQpbICAgMzEuOTc5NjUwXSBub3V2ZWF1IDAwMDA6MDI6MDAuMDogYmlv
czogdmVyc2lvbiA4Ni4wOC4yYS4wMC44NQpbICAgMzIuNjc5ODYyXSBub3V2ZWF1IDAwMDA6
MDI6MDAuMDogcG11OiBmaXJtd2FyZSB1bmF2YWlsYWJsZQpbICAgMzMuNTkzNzkxXSBub3V2
ZWF1IDAwMDA6MDI6MDAuMDogZmI6IDIwNDggTWlCIEdERFI1ClsgICAzMy42MzIzNTddIG5v
dXZlYXUgMDAwMDowMjowMC4wOiBEUk06IFZSQU06IDIwNDggTWlCClsgICAzMy42MzIzNTld
IG5vdXZlYXUgMDAwMDowMjowMC4wOiBEUk06IEdBUlQ6IDUzNjg3MDkxMiBNaUIKWyAgIDMz
LjYzMjM2Ml0gbm91dmVhdSAwMDAwOjAyOjAwLjA6IERSTTogQklUIHRhYmxlICdBJyBub3Qg
Zm91bmQKWyAgIDMzLjYzMjM2M10gbm91dmVhdSAwMDAwOjAyOjAwLjA6IERSTTogQklUIHRh
YmxlICdMJyBub3QgZm91bmQKWyAgIDMzLjYzMjM2NV0gbm91dmVhdSAwMDAwOjAyOjAwLjA6
IERSTTogUG9pbnRlciB0byBUTURTIHRhYmxlIG5vdCBmb3VuZApbICAgMzMuNjMyMzY2XSBu
b3V2ZWF1IDAwMDA6MDI6MDAuMDogRFJNOiBEQ0IgdmVyc2lvbiA0LjEKWyAgIDMzLjYzMzY0
M10gbm91dmVhdSAwMDAwOjAyOjAwLjA6IERSTTogTU06IHVzaW5nIENPUFkgZm9yIGJ1ZmZl
ciBjb3BpZXMKWyAgIDMzLjYzNDAzNV0gW2RybV0gSW5pdGlhbGl6ZWQgbm91dmVhdSAxLjMu
MSAyMDEyMDgwMSBmb3IgMDAwMDowMjowMC4wIG9uIG1pbm9yIDEKWyAgIDUzLjA1Mjc4Ml0g
bm91dmVhdSAwMDAwOjAyOjAwLjA6IEVuYWJsaW5nIEhEQSBjb250cm9sbGVyClsgICA5OC43
NTY2NDBdIG5vdXZlYXUgMDAwMDowMjowMC4wOiBFbmFibGluZyBIREEgY29udHJvbGxlcgpb
ICAxMTUuODIwMzkwXSBub3V2ZWF1IDAwMDA6MDI6MDAuMDogRW5hYmxpbmcgSERBIGNvbnRy
b2xsZXIKWyAgMTUwLjE1MTgyNl0gbm91dmVhdSAwMDAwOjAyOjAwLjA6IEVuYWJsaW5nIEhE
QSBjb250cm9sbGVyClsgIDE2My43OTkzMTFdIG5vdXZlYXUgMDAwMDowMjowMC4wOiBFbmFi
bGluZyBIREEgY29udHJvbGxlcgpbICA1MTcuODY0OTc5XSBub3V2ZWF1IDAwMDA6MDI6MDAu
MDogRW5hYmxpbmcgSERBIGNvbnRyb2xsZXIKWyAgODkzLjg1NDcwMl0gbm91dmVhdSAwMDAw
OjAyOjAwLjA6IEVuYWJsaW5nIEhEQSBjb250cm9sbGVyClsgMTA0My45MzY3MzNdIG5vdXZl
YXUgMDAwMDowMjowMC4wOiBFbmFibGluZyBIREEgY29udHJvbGxlcgpbIDEwNjIuNjAzNzAy
XSBub3V2ZWF1IDAwMDA6MDI6MDAuMDogRW5hYmxpbmcgSERBIGNvbnRyb2xsZXIKWyAxMTY5
LjM1Njg3Ml0gbm91dmVhdSAwMDAwOjAyOjAwLjA6IEVuYWJsaW5nIEhEQSBjb250cm9sbGVy
ClsgMTU4NS42Mjc5ODBdIG5vdXZlYXUgMDAwMDowMjowMC4wOiBFbmFibGluZyBIREEgY29u
dHJvbGxlcgoKY2F0IC9zeXMvYnVzL3BjaS9kZXZpY2VzLzAwMDA6MDI6MDAuMC9wb3dlci9j
b250cm9sCmF1dG8KbHh1c2VyQGx4dXNlci1Td2lmdC1TRjMxNC01Nkc6fiQgY2F0IC9zeXMv
YnVzL3BjaS9kZXZpY2VzLzAwMDA6MDI6MDAuMC9wb3dlci9ydW50aW1lX3N0YXR1cwphY3Rp
dmUKCgo=
--------------rXTU10Ky280u0iP2PgAAnybB
Content-Type: text/plain; charset=UTF-8; name="Nvidia Ubuntu 20.04"
Content-Disposition: attachment; filename="Nvidia Ubuntu 20.04"
Content-Transfer-Encoding: base64

bHh1c2VyQGx4dXNlci1Td2lmdC1TRjMxNC01Nkc6fiQgbHNwY2kgLWsgfCBncmVwIC1BIDIg
LUUgIihWR0F8M0QpIgowMDowMi4wIFZHQSBjb21wYXRpYmxlIGNvbnRyb2xsZXI6IEludGVs
IENvcnBvcmF0aW9uIFVIRCBHcmFwaGljcyA2MjAgKFdoaXNrZXkgTGFrZSkKCVN1YnN5c3Rl
bTogQWNlciBJbmNvcnBvcmF0ZWQgW0FMSV0gVUhEIEdyYXBoaWNzIDYyMCAoV2hpc2tleSBM
YWtlKQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IGk5MTUKLS0KMDI6MDAuMCAzRCBjb250cm9s
bGVyOiBOVklESUEgQ29ycG9yYXRpb24gR1AxMDhNIFtHZUZvcmNlIE1YMjUwXSAocmV2IGEx
KQoJU3Vic3lzdGVtOiBBY2VyIEluY29ycG9yYXRlZCBbQUxJXSBHUDEwOE0gW0dlRm9yY2Ug
TVgyNTBdCglLZXJuZWwgZHJpdmVyIGluIHVzZTogbnZpZGlhCmx4dXNlckBseHVzZXItU3dp
ZnQtU0YzMTQtNTZHOn4kIHN1ZG8gZG1lc2cgfCBncmVwIC1pRSAibnZpZGlhfG52cm18cGNp
IDAwMDA6MDI6MDAuMCIKW3N1ZG9dIFBhc3N3b3J0IGbDvHIgbHh1c2VyOiAKWyAgICAwLjU4
MjI2OF0gcGNpIDAwMDA6MDI6MDAuMDogWzEwZGU6MWQxM10gdHlwZSAwMCBjbGFzcyAweDAz
MDIwMApbICAgIDAuNTgyMjk0XSBwY2kgMDAwMDowMjowMC4wOiByZWcgMHgxMDogW21lbSAw
eGEzMDAwMDAwLTB4YTNmZmZmZmZdClsgICAgMC41ODIzMTJdIHBjaSAwMDAwOjAyOjAwLjA6
IHJlZyAweDE0OiBbbWVtIDB4OTAwMDAwMDAtMHg5ZmZmZmZmZiA2NGJpdCBwcmVmXQpbICAg
IDAuNTgyMzQzXSBwY2kgMDAwMDowMjowMC4wOiByZWcgMHgxYzogW21lbSAweGEwMDAwMDAw
LTB4YTFmZmZmZmYgNjRiaXQgcHJlZl0KWyAgICAwLjU4MjM2MV0gcGNpIDAwMDA6MDI6MDAu
MDogcmVnIDB4MjQ6IFtpbyAgMHgzMDAwLTB4MzA3Zl0KWyAgICAwLjU4MjM3NV0gcGNpIDAw
MDA6MDI6MDAuMDogcmVnIDB4MzA6IFttZW0gMHhmZmY4MDAwMC0weGZmZmZmZmZmIHByZWZd
ClsgICAgMC41ODI0MTFdIHBjaSAwMDAwOjAyOjAwLjA6IEVuYWJsaW5nIEhEQSBjb250cm9s
bGVyClsgICAgMC43MTMyODZdIHBjaSAwMDAwOjAyOjAwLjA6IGNhbid0IGNsYWltIEJBUiA2
IFttZW0gMHhmZmY4MDAwMC0weGZmZmZmZmZmIHByZWZdOiBubyBjb21wYXRpYmxlIGJyaWRn
ZSB3aW5kb3cKWyAgICAwLjcxMzY2NF0gcGNpIDAwMDA6MDI6MDAuMDogQkFSIDY6IG5vIHNw
YWNlIGZvciBbbWVtIHNpemUgMHgwMDA4MDAwMCBwcmVmXQpbICAgIDAuNzEzNjY4XSBwY2kg
MDAwMDowMjowMC4wOiBCQVIgNjogZmFpbGVkIHRvIGFzc2lnbiBbbWVtIHNpemUgMHgwMDA4
MDAwMCBwcmVmXQpbICAgNDUuNjA3MDA5XSBudmlkaWE6IGxvYWRpbmcgb3V0LW9mLXRyZWUg
bW9kdWxlIHRhaW50cyBrZXJuZWwuClsgICA0NS42MDcwMjBdIG52aWRpYTogbW9kdWxlIGxp
Y2Vuc2UgJ05WSURJQScgdGFpbnRzIGtlcm5lbC4KWyAgIDQ1LjYyNzkxN10gbnZpZGlhOiBt
b2R1bGUgdmVyaWZpY2F0aW9uIGZhaWxlZDogc2lnbmF0dXJlIGFuZC9vciByZXF1aXJlZCBr
ZXkgbWlzc2luZyAtIHRhaW50aW5nIGtlcm5lbApbICAgNDUuNjQ2NDUyXSBudmlkaWEtbnZs
aW5rOiBOdmxpbmsgQ29yZSBpcyBiZWluZyBpbml0aWFsaXplZCwgbWFqb3IgZGV2aWNlIG51
bWJlciA1MDgKWyAgIDQ1LjY0NzY0Ml0gbnZpZGlhIDAwMDA6MDI6MDAuMDogZW5hYmxpbmcg
ZGV2aWNlICgwMTA2IC0+IDAxMDcpClsgICA0NS43NjM2OTNdIE5WUk06IGxvYWRpbmcgTlZJ
RElBIFVOSVggeDg2XzY0IEtlcm5lbCBNb2R1bGUgIDU3MC4xMzMuMDcgIEZyaSBNYXIgMTQg
MTM6MTI6MDcgVVRDIDIwMjUKWyAgIDQ2LjcyMDg2Ml0gbnZpZGlhLW1vZGVzZXQ6IExvYWRp
bmcgTlZJRElBIEtlcm5lbCBNb2RlIFNldHRpbmcgRHJpdmVyIGZvciBVTklYIHBsYXRmb3Jt
cyAgNTcwLjEzMy4wNyAgRnJpIE1hciAxNCAxMjo0Mjo1NyBVVEMgMjAyNQpbICAgNDYuODQ2
NDU1XSBbZHJtXSBbbnZpZGlhLWRybV0gW0dQVSBJRCAweDAwMDAwMjAwXSBMb2FkaW5nIGRy
aXZlcgpbICAgNDcuMjA5ODg3XSBbZHJtXSBJbml0aWFsaXplZCBudmlkaWEtZHJtIDAuMC4w
IDIwMTYwMjAyIGZvciAwMDAwOjAyOjAwLjAgb24gbWlub3IgMQpbICAgNDguNTU0OTM4XSBu
dmlkaWFfdXZtOiBtb2R1bGUgdXNlcyBzeW1ib2xzIGZyb20gcHJvcHJpZXRhcnkgbW9kdWxl
IG52aWRpYSwgaW5oZXJpdGluZyB0YWludC4KWyAgIDQ4Ljc4OTIxNV0gYXVkaXQ6IHR5cGU9
MTQwMCBhdWRpdCgxNzc3MzE0NjIzLjUwNzo5KTogYXBwYXJtb3I9IlNUQVRVUyIgb3BlcmF0
aW9uPSJwcm9maWxlX2xvYWQiIHByb2ZpbGU9InVuY29uZmluZWQiIG5hbWU9Im52aWRpYV9t
b2Rwcm9iZSIgcGlkPTg1MSBjb21tPSJhcHBhcm1vcl9wYXJzZXIiClsgICA0OC43ODkyMzRd
IGF1ZGl0OiB0eXBlPTE0MDAgYXVkaXQoMTc3NzMxNDYyMy41MDc6MTApOiBhcHBhcm1vcj0i
U1RBVFVTIiBvcGVyYXRpb249InByb2ZpbGVfbG9hZCIgcHJvZmlsZT0idW5jb25maW5lZCIg
bmFtZT0ibnZpZGlhX21vZHByb2JlLy9rbW9kIiBwaWQ9ODUxIGNvbW09ImFwcGFybW9yX3Bh
cnNlciIKbHh1c2VyQGx4dXNlci1Td2lmdC1TRjMxNC01Nkc6fiQgbnZpZGlhLXNtaQpNb24g
QXByIDI3IDIwOjM5OjI0IDIwMjYgICAgICAgCistLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLSsKfCBOVklESUEtU01JIDU3MC4xMzMuMDcgICAgICAgICAgICAgRHJpdmVy
IFZlcnNpb246IDU3MC4xMzMuMDcgICAgIENVREEgVmVyc2lvbjogMTIuOCAgICAgfAp8LS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCnwgR1BVICBOYW1lICAgICAgICAg
ICAgICAgICBQZXJzaXN0ZW5jZS1NIHwgQnVzLUlkICAgICAgICAgIERpc3AuQSB8IFZvbGF0
aWxlIFVuY29yci4gRUNDIHwKfCBGYW4gIFRlbXAgICBQZXJmICAgICAgICAgIFB3cjpVc2Fn
ZS9DYXAgfCAgICAgICAgICAgTWVtb3J5LVVzYWdlIHwgR1BVLVV0aWwgIENvbXB1dGUgTS4g
fAp8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAgICAgICAgICAgIE1JRyBNLiB8Cnw9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PSs9PT09PT09PT09PT09PT09PT09PT09PT0r
PT09PT09PT09PT09PT09PT09PT09PXwKfCAgIDAgIE5WSURJQSBHZUZvcmNlIE1YMjUwICAg
ICAgICAgICBPZmYgfCAgIDAwMDAwMDAwOjAyOjAwLjAgT2ZmIHwgICAgICAgICAgICAgICAg
ICBOL0EgfAp8IE4vQSAgIDM4QyAgICBQOCAgICAgICAgICAgIE4vQSAgLyA1MDAxVyB8ICAg
ICAgMTBNaUIgLyAgIDIwNDhNaUIgfCAgICAgIDAlICAgICAgRGVmYXVsdCB8CnwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICB8ICAgICAgICAgICAgICAgICAgTi9BIHwKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0t
LS0tLS0tLS0tLS0tKwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAorLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0rCnwgUHJvY2Vzc2VzOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwKfCAgR1BVICAgR0kgICBDSSAgICAgICAgICAgICAgUElEICAg
VHlwZSAgIFByb2Nlc3MgbmFtZSAgICAgICAgICAgICAgICAgICAgICAgIEdQVSBNZW1vcnkg
fAp8ICAgICAgICBJRCAgIElEICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgVXNhZ2UgICAgICB8Cnw9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PXwKfCAgICAwICAgTi9BICBOL0EgICAgICAgICAgICAx
MTUzICAgICAgRyAgIC91c3IvbGliL3hvcmcvWG9yZyAgICAgICAgICAgICAgICAgICAgICAg
IDRNaUIgfAp8ICAgIDAgICBOL0EgIE4vQSAgICAgICAgICAgIDE4MzIgICAgICBHICAgL3Vz
ci9saWIveG9yZy9Yb3JnICAgICAgICAgICAgICAgICAgICAgICAgNE1pQiB8CistLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSsKbHh1c2VyQGx4dXNlci1Td2lmdC1TRjMx
NC01Nkc6fiQgcHJpbWUtc2VsZWN0IGdseGluZm8gLUIgfCBncmVwIC1pICJyZW5kZXJlciIK
VXNhZ2U6IC91c3IvYmluL3ByaW1lLXNlbGVjdCBudmlkaWF8aW50ZWx8b24tZGVtYW5kfHF1
ZXJ5Cmx4dXNlckBseHVzZXItU3dpZnQtU0YzMTQtNTZHOn4kIHByaW1lLXNlbGVjdCBnbG1h
cmsyClVzYWdlOiAvdXNyL2Jpbi9wcmltZS1zZWxlY3QgbnZpZGlhfGludGVsfG9uLWRlbWFu
ZHxxdWVyeQpseHVzZXJAbHh1c2VyLVN3aWZ0LVNGMzE0LTU2Rzp+JCBfX05WX1BSSU1FX1JF
TkRFUl9PRkZMT0FEPTEgX19HTFhfVkVORE9SX0xJQlJBUllfTkFNRT1udmlkaWEgZ2x4aW5m
byAtQiB8IGdyZXAgLWkgInJlbmRlcmVyIgpPcGVuR0wgcmVuZGVyZXIgc3RyaW5nOiBOVklE
SUEgR2VGb3JjZSBNWDI1MC9QQ0llL1NTRTIKbHh1c2VyQGx4dXNlci1Td2lmdC1TRjMxNC01
Nkc6fiQgX19OVl9QUklNRV9SRU5ERVJfT0ZGTE9BRD0xIF9fR0xYX1ZFTkRPUl9MSUJSQVJZ
X05BTUU9bnZpZGlhIGdseGluZm8gLUIgfCBncmVwIC1pICJyZW5kZXJlciIKT3BlbkdMIHJl
bmRlcmVyIHN0cmluZzogTlZJRElBIEdlRm9yY2UgTVgyNTAvUENJZS9TU0UyCgpfX05WX1BS
SU1FX1JFTkRFUl9PRkZMT0FEPTEgX19HTFhfVkVORE9SX0xJQlJBUllfTkFNRT1udmlkaWEg
Z2xtYXJrMgo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CiAgICBnbG1hcmsyIDIwMjEuMDIKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQogICAgT3BlbkdMIEluZm9ybWF0aW9u
CiAgICBHTF9WRU5ET1I6ICAgICBOVklESUEgQ29ycG9yYXRpb24KICAgIEdMX1JFTkRFUkVS
OiAgIE5WSURJQSBHZUZvcmNlIE1YMjUwL1BDSWUvU1NFMgogICAgR0xfVkVSU0lPTjogICAg
NC42LjAgTlZJRElBIDU3MC4xMzMuMDcKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQpbYnVpbGRdIHVzZS12Ym89ZmFsc2U6IEZQUzog
MTIxMyBGcmFtZVRpbWU6IDAuODI0IG1zCltidWlsZF0gdXNlLXZibz10cnVlOiBGUFM6IDE0
MTQgRnJhbWVUaW1lOiAwLjcwNyBtcwpbdGV4dHVyZV0gdGV4dHVyZS1maWx0ZXI9bmVhcmVz
dDogRlBTOiAxNDAwIEZyYW1lVGltZTogMC43MTQgbXMKW3RleHR1cmVdIHRleHR1cmUtZmls
dGVyPWxpbmVhcjogRlBTOiAxNDAwIEZyYW1lVGltZTogMC43MTQgbXMKW3RleHR1cmVdIHRl
eHR1cmUtZmlsdGVyPW1pcG1hcDogRlBTOiAxNDA4IEZyYW1lVGltZTogMC43MTAgbXMKW3No
YWRpbmddIHNoYWRpbmc9Z291cmF1ZDogRlBTOiAxMzY3IEZyYW1lVGltZTogMC43MzIgbXMK
W3NoYWRpbmddIHNoYWRpbmc9Ymxpbm4tcGhvbmctaW5mOiBGUFM6IDEzNjYgRnJhbWVUaW1l
OiAwLjczMiBtcwpbc2hhZGluZ10gc2hhZGluZz1waG9uZzogRlBTOiAxMzU2IEZyYW1lVGlt
ZTogMC43MzcgbXMKW3NoYWRpbmddIHNoYWRpbmc9Y2VsOiBGUFM6IDEzNjEgRnJhbWVUaW1l
OiAwLjczNSBtcwpbYnVtcF0gYnVtcC1yZW5kZXI9aGlnaC1wb2x5OiBGUFM6IDEyNzkgRnJh
bWVUaW1lOiAwLjc4MiBtcwpbYnVtcF0gYnVtcC1yZW5kZXI9bm9ybWFsczogRlBTOiAxNDMw
IEZyYW1lVGltZTogMC42OTkgbXMKW2J1bXBdIGJ1bXAtcmVuZGVyPWhlaWdodDogRlBTOiAx
NDMyIEZyYW1lVGltZTogMC42OTggbXMKW2VmZmVjdDJkXSBrZXJuZWw9MCwxLDA7MSwtNCwx
OzAsMSwwOzogRlBTOiAxMzE2IEZyYW1lVGltZTogMC43NjAgbXMKW2VmZmVjdDJkXSBrZXJu
ZWw9MSwxLDEsMSwxOzEsMSwxLDEsMTsxLDEsMSwxLDE7OiBGUFM6IDExODYgRnJhbWVUaW1l
OiAwLjg0MyBtcwpbcHVsc2FyXSBsaWdodD1mYWxzZTpxdWFkcz01OnRleHR1cmU9ZmFsc2U6
IEZQUzogMTQwMiBGcmFtZVRpbWU6IDAuNzEzIG1zCltkZXNrdG9wXSBibHVyLXJhZGl1cz01
OmVmZmVjdD1ibHVyOnBhc3Nlcz0xOnNlcGFyYWJsZT10cnVlOndpbmRvd3M9NDogRlBTOiAx
MDg2IEZyYW1lVGltZTogMC45MjEgbXMKW2Rlc2t0b3BdIGVmZmVjdD1zaGFkb3c6d2luZG93
cz00OiBGUFM6IDEyNjkgRnJhbWVUaW1lOiAwLjc4OCBtcwpbYnVmZmVyXSBjb2x1bW5zPTIw
MDppbnRlcmxlYXZlPWZhbHNlOnVwZGF0ZS1kaXNwZXJzaW9uPTAuOTp1cGRhdGUtZnJhY3Rp
b249MC41OnVwZGF0ZS1tZXRob2Q9bWFwOiBGUFM6IDg4NSBGcmFtZVRpbWU6IDEuMTMwIG1z
CltidWZmZXJdIGNvbHVtbnM9MjAwOmludGVybGVhdmU9ZmFsc2U6dXBkYXRlLWRpc3BlcnNp
b249MC45OnVwZGF0ZS1mcmFjdGlvbj0wLjU6dXBkYXRlLW1ldGhvZD1zdWJkYXRhOiBGUFM6
IDEwNDUgRnJhbWVUaW1lOiAwLjk1NyBtcwpbYnVmZmVyXSBjb2x1bW5zPTIwMDppbnRlcmxl
YXZlPXRydWU6dXBkYXRlLWRpc3BlcnNpb249MC45OnVwZGF0ZS1mcmFjdGlvbj0wLjU6dXBk
YXRlLW1ldGhvZD1tYXA6IEZQUzogODIzIEZyYW1lVGltZTogMS4yMTUgbXMKW2lkZWFzXSBz
cGVlZD1kdXJhdGlvbjogRlBTOiAxNDA0IEZyYW1lVGltZTogMC43MTIgbXMKW2plbGx5Zmlz
aF0gPGRlZmF1bHQ+OiBGUFM6IDEyMDQgRnJhbWVUaW1lOiAwLjgzMSBtcwpbdGVycmFpbl0g
PGRlZmF1bHQ+OiBGUFM6IDQxOSBGcmFtZVRpbWU6IDIuMzg3IG1zCltzaGFkb3ddIDxkZWZh
dWx0PjogRlBTOiAxMTk5IEZyYW1lVGltZTogMC44MzQgbXMKW3JlZnJhY3RdIDxkZWZhdWx0
PjogRlBTOiA3MDUgRnJhbWVUaW1lOiAxLjQxOCBtcwpbY29uZGl0aW9uYWxzXSBmcmFnbWVu
dC1zdGVwcz0wOnZlcnRleC1zdGVwcz0wOiBGUFM6IDEzOTAgRnJhbWVUaW1lOiAwLjcxOSBt
cwpbY29uZGl0aW9uYWxzXSBmcmFnbWVudC1zdGVwcz01OnZlcnRleC1zdGVwcz0wOiBGUFM6
IDE0MDUgRnJhbWVUaW1lOiAwLjcxMiBtcwpbY29uZGl0aW9uYWxzXSBmcmFnbWVudC1zdGVw
cz0wOnZlcnRleC1zdGVwcz01OiBGUFM6IDEzOTYgRnJhbWVUaW1lOiAwLjcxNiBtcwpbZnVu
Y3Rpb25dIGZyYWdtZW50LWNvbXBsZXhpdHk9bG93OmZyYWdtZW50LXN0ZXBzPTU6IEZQUzog
MTM5MyBGcmFtZVRpbWU6IDAuNzE4IG1zCltmdW5jdGlvbl0gZnJhZ21lbnQtY29tcGxleGl0
eT1tZWRpdW06ZnJhZ21lbnQtc3RlcHM9NTogRlBTOiAxNDA3IEZyYW1lVGltZTogMC43MTEg
bXMKW2xvb3BdIGZyYWdtZW50LWxvb3A9ZmFsc2U6ZnJhZ21lbnQtc3RlcHM9NTp2ZXJ0ZXgt
c3RlcHM9NTogRlBTOiAxNDMwIEZyYW1lVGltZTogMC42OTkgbXMKW2xvb3BdIGZyYWdtZW50
LXN0ZXBzPTU6ZnJhZ21lbnQtdW5pZm9ybT1mYWxzZTp2ZXJ0ZXgtc3RlcHM9NTogRlBTOiAx
NDQwIEZyYW1lVGltZTogMC42OTQgbXMKW2xvb3BdIGZyYWdtZW50LXN0ZXBzPTU6ZnJhZ21l
bnQtdW5pZm9ybT10cnVlOnZlcnRleC1zdGVwcz01OiBGUFM6IDEzOTEgRnJhbWVUaW1lOiAw
LjcxOSBtcwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnbG1hcmsyIFNj
b3JlOiAxMjYxIAo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09CgoKY2F0IC9wcm9jL2NtZGxpbmUKQk9PVF9JTUFHRT0vYm9vdC92bWxp
bnV6LTUuMTUuMC0xMzktZ2VuZXJpYyByb290PVVVSUQ9ZTgyZmZhZWMtZjQwYi00YzgyLTg4
NjUtNzJmZWEwNTc1ZmNiIHJvIHF1aWV0IHNwbGFzaCB2dC5oYW5kb2ZmPTcKbHh1c2VyQGx4
dXNlci1Td2lmdC1TRjMxNC01Nkc6fiQgc3VkbyBncmVwIC1FICJPcGVuUm18RW5hYmxlR3B1
RmlybXdhcmV8RHluYW1pY1Bvd2VyTWFuYWdlbWVudCIgL3Zhci9sb2cvWG9yZy4wLmxvZwpb
c3Vkb10gUGFzc3dvcnQgZsO8ciBseHVzZXI6IApncmVwOiAvdmFyL2xvZy9Yb3JnLjAubG9n
OiBEYXRlaSBvZGVyIFZlcnplaWNobmlzIG5pY2h0IGdlZnVuZGVuCmx4dXNlckBseHVzZXIt
U3dpZnQtU0YzMTQtNTZHOn4kIHN1ZG8gc3lzdG9vbCAtdiAtbSBudmlkaWEgfCBncmVwIC1F
ICJOVnJlZ18oT3BlblJtfEVuYWJsZUdwdUZpcm13YXJlfER5bmFtaWNQb3dlck1hbmFnZW1l
bnQpIgpzdWRvOiBzeXN0b29sOiBCZWZlaGwgbmljaHQgZ2VmdW5kZW4KbHh1c2VyQGx4dXNl
ci1Td2lmdC1TRjMxNC01Nkc6fiQgc3VkbyBhcHQgaW5zdGFsbCBzeXNmc3V0aWxzClBha2V0
bGlzdGVuIHdlcmRlbiBnZWxlc2VuLi4uIEZlcnRpZwpBYmjDpG5naWdrZWl0c2JhdW0gd2ly
ZCBhdWZnZWJhdXQuICAgICAgIApTdGF0dXNpbmZvcm1hdGlvbmVuIHdlcmRlbiBlaW5nZWxl
c2VuLi4uLiBGZXJ0aWcKRGllIGZvbGdlbmRlbiBQYWtldGUgd3VyZGVuIGF1dG9tYXRpc2No
IGluc3RhbGxpZXJ0IHVuZCB3ZXJkZW4gbmljaHQgbWVociBiZW7DtnRpZ3Q6CiAgY2hyb21p
dW0tY29kZWNzLWZmbXBlZy1leHRyYSBnc3RyZWFtZXIxLjAtdmFhcGkgbGliZ3N0cmVhbWVy
LXBsdWdpbnMtYmFkMS4wLTAgbGlidmEtd2F5bGFuZDIKVmVyd2VuZGVuIFNpZSDCu3N1ZG8g
YXB0IGF1dG9yZW1vdmXCqywgdW0gc2llIHp1IGVudGZlcm5lbi4KRGllIGZvbGdlbmRlbiB6
dXPDpHR6bGljaGVuIFBha2V0ZSB3ZXJkZW4gaW5zdGFsbGllcnQ6CiAgbGlic3lzZnMyCkRp
ZSBmb2xnZW5kZW4gTkVVRU4gUGFrZXRlIHdlcmRlbiBpbnN0YWxsaWVydDoKICBsaWJzeXNm
czIgc3lzZnN1dGlscwowIGFrdHVhbGlzaWVydCwgMiBuZXUgaW5zdGFsbGllcnQsIDAgenUg
ZW50ZmVybmVuIHVuZCAzNzkgbmljaHQgYWt0dWFsaXNpZXJ0LgpFcyBtw7xzc2VuIDMyLDUg
a0IgYW4gQXJjaGl2ZW4gaGVydW50ZXJnZWxhZGVuIHdlcmRlbi4KTmFjaCBkaWVzZXIgT3Bl
cmF0aW9uIHdlcmRlbiAxMzAga0IgUGxhdHRlbnBsYXR6IHp1c8OkdHpsaWNoIGJlbnV0enQu
Ck3DtmNodGVuIFNpZSBmb3J0ZmFocmVuPyBbSi9uXSBqCkhvbGVuOjEgaHR0cDovL2RlLmFy
Y2hpdmUudWJ1bnR1LmNvbS91YnVudHUgZm9jYWwvbWFpbiBhbWQ2NCBsaWJzeXNmczIgYW1k
NjQgMi4xLjArcmVwYWNrLTYgWzE4LDgga0JdCkhvbGVuOjIgaHR0cDovL2RlLmFyY2hpdmUu
dWJ1bnR1LmNvbS91YnVudHUgZm9jYWwvbWFpbiBhbWQ2NCBzeXNmc3V0aWxzIGFtZDY0IDIu
MS4wK3JlcGFjay02IFsxMyw3IGtCXQpFcyB3dXJkZW4gMzIsNSBrQiBpbiAwIHMgZ2Vob2x0
ICgxMTUga0IvcykuClZvcm1hbHMgbmljaHQgYXVzZ2V3w6RobHRlcyBQYWtldCBsaWJzeXNm
czI6YW1kNjQgd2lyZCBnZXfDpGhsdC4KKExlc2UgRGF0ZW5iYW5rIC4uLiAxOTE2OTAgRGF0
ZWllbiB1bmQgVmVyemVpY2huaXNzZSBzaW5kIGRlcnplaXQgaW5zdGFsbGllcnQuKQpWb3Ji
ZXJlaXR1bmcgenVtIEVudHBhY2tlbiB2b24gLi4uL2xpYnN5c2ZzMl8yLjEuMCtyZXBhY2st
Nl9hbWQ2NC5kZWIgLi4uCkVudHBhY2tlbiB2b24gbGlic3lzZnMyOmFtZDY0ICgyLjEuMCty
ZXBhY2stNikgLi4uClZvcm1hbHMgbmljaHQgYXVzZ2V3w6RobHRlcyBQYWtldCBzeXNmc3V0
aWxzIHdpcmQgZ2V3w6RobHQuClZvcmJlcmVpdHVuZyB6dW0gRW50cGFja2VuIHZvbiAuLi4v
c3lzZnN1dGlsc18yLjEuMCtyZXBhY2stNl9hbWQ2NC5kZWIgLi4uCkVudHBhY2tlbiB2b24g
c3lzZnN1dGlscyAoMi4xLjArcmVwYWNrLTYpIC4uLgpsaWJzeXNmczI6YW1kNjQgKDIuMS4w
K3JlcGFjay02KSB3aXJkIGVpbmdlcmljaHRldCAuLi4Kc3lzZnN1dGlscyAoMi4xLjArcmVw
YWNrLTYpIHdpcmQgZWluZ2VyaWNodGV0IC4uLgpUcmlnZ2VyIGbDvHIgc3lzdGVtZCAoMjQ1
LjQtNHVidW50dTMuMjApIHdlcmRlbiB2ZXJhcmJlaXRldCAuLi4KVHJpZ2dlciBmw7xyIG1h
bi1kYiAoMi45LjEtMSkgd2VyZGVuIHZlcmFyYmVpdGV0IC4uLgpUcmlnZ2VyIGbDvHIgbGli
Yy1iaW4gKDIuMzEtMHVidW50dTkuOSkgd2VyZGVuIHZlcmFyYmVpdGV0IC4uLgpseHVzZXJA
bHh1c2VyLVN3aWZ0LVNGMzE0LTU2Rzp+JCBzdWRvIHN5c3Rvb2wgLXYgLW0gbnZpZGlhIHwg
Z3JlcCAtRSAiTlZyZWdfKE9wZW5SbXxFbmFibGVHcHVGaXJtd2FyZXxEeW5hbWljUG93ZXJN
YW5hZ2VtZW50KSIKbHh1c2VyQGx4dXNlci1Td2lmdC1TRjMxNC01Nkc6fiQgc3VkbyBkbWVz
ZyB8IGdyZXAgLWkgIkFDUEk6IE9TIgpseHVzZXJAbHh1c2VyLVN3aWZ0LVNGMzE0LTU2Rzp+
JCBzdWRvIGRtZXNnIHwgZ3JlcCAtaSAiQUNQSTogT1MiCmx4dXNlckBseHVzZXItU3dpZnQt
U0YzMTQtNTZHOn4kIAoKCgo=

--------------rXTU10Ky280u0iP2PgAAnybB--
