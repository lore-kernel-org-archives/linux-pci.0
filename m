Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6C3B774F
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733740; cv=none; b=P/4E3c0ekU01kynBFDQj9u/P79xMw6z8wKjtZUtqnqjrt8hStitTi1GimML+jxKTpja1pqxhUNW8jw3mHqUIZS9HuNLBA1DrOF1iSf3d7PXYX5ZAUPHuGIwPrVk7cKYdKb7d0dAOQYW+gBuVluB2EeEf/sxHEVSARo6rwQ8pio8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733740; c=relaxed/simple;
	bh=tUGgw12GXUTNfxwG+MV+4xDKkocFA1wjnlghMhFlDoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWcKB5I7ZcWQJYDeQReHlrlxZDMLP1szw9zxi8nVjow8aJj5BtWAoSP26To/GVDdmqweQPaCTpxuiZ4omDRZNB5j41doqVUJkXxfabVdrJ6PH/eqNWFUm/Ql0yKXaSuB1u1S/rzURJVIfSmluQGxJZuV9zp5KHurTm+OBl75QJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KljXYDSE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WbZKG/fW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KljXYDSE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WbZKG/fW"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RuP4451445
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=STSvqtYC3jQxrnHRxquHS2J0
	Fwws+dd4nvdb7Vv4YSs=; b=KljXYDSEh6Op3gBy3d+v7jPnZEmpC/XWH+UalwJw
	VevhhJO8afqx08skrk845f5PH0MYRn1sImnT/Uns+sPVVwst0brGmNWWB0/GKKaU
	iVOdckL256TpeHFv4NrSy819idOEzkOLSyipWDmprgKCsXBLb6JP4/g2LcrgsMqx
	JGmXagwrqkl+op8L2RwA7U4RZIZPn1y6/Ay1MP1K3CbWVTiDMvovMTGQPcVXzwC/
	UXfmrlZDIffK+OCX4zYZfEU/2qAllU7QakXf6ccOezG0nnWN9LzWMTGuRJGhQndP
	KBrxt3e/VGTbUXNKETi5bha8/q1cymCnczYNbSvgyXGLMg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9r1gh7ba-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 08:42:17 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1a97644aso8455441cf.2
        for <linux-pci@vger.kernel.org>; Wed, 26 Aug 2026 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787733737; x=1788338537; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=STSvqtYC3jQxrnHRxquHS2J0Fwws+dd4nvdb7Vv4YSs=;
        b=WbZKG/fWHubJQYHOFW57ymA7X0VnOanfHhoSHcguyIaQ/fb357fdnvOlggkL+GRHiW
         LnWcluBWqthaXi/gahXRZ9FIvvvvw6iQfx9L2BQhMPIkNPBdO8yXgHC/SRCMq87CduhH
         3I33s5wJbWFvmNj+lHgn4jex1792sGKFEFIIYCd0oviARQiALlifJj4rXl9g06yjFfJg
         1v7qUii2oVxOLBY3VvuE8kecX8Zt4/FHVeigRmASdD6h8iasHc6t5T/V77XGbEYpFRwA
         eM5D2OX9Z34LD0UykxIpDpEFd72s4WOh/pnSXjgiWfAuvoMUgPn0RIDvIU+1sYlDfkkS
         PN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787733737; x=1788338537;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STSvqtYC3jQxrnHRxquHS2J0Fwws+dd4nvdb7Vv4YSs=;
        b=Fl9prRpce+6mS0fzMUiI8kwuKqNvOwWFH4ScvxOH1ktk2gMFh1hUvwuaN+kLKVHuDM
         H2WqXlJKFBaS8lXan/ypJP/GRP2dGQE5arFewCOBBhLN6zIc0IhQK5hmojTYjBve0leJ
         XJGmp+QMeUbMWnF5fLQKiJ8EzwSVQhQdY6suFUj4J+I/wIvJttaRuY/XAgNRzrdP5JCy
         N7QTFoElwDlJXnBU5WhEe78dOl7NDOWvYpXzlsQ6ofjTffzDZcMWUb+M/b0954HfHXLg
         LE6oinvrBs06EvWZqJFHy/HAgKczh17YwnmFwd5yHyrojd2Q/fn6g5AEsb4SfZRfRdqa
         tTag==
X-Gm-Message-State: AFuF++k16XhJVO5rotxOLWrmpQVSCOy+iGdH3031I9fDv2aCG0ysF+ha
	hmY/1mTyQ0LQqVe/N6R18TiAJ5DgV97UmxcfBuDTDZqWFGIiEUvUWEaJ3K7vNXYASup97Nkr1e9
	12rQnYZpL3fE9Wt6aQ5h8bjOcLzfHa2MjAe2FHFU9Jfi1iyR2jJ5lsVvLNwYjztk=
X-Gm-Gg: AR+sD11yOvKxQpyqIxUNsqIgz4lWc11If8mlnvO0g8s57cmzH4Avncc31KQWKyWTKVY
	wFbFyvN27cV4zu6ld42M971C65sVowX4Mk6V3875vrmhYIlx6IkVzRnt6DGqSL92/PXYSsgtFix
	kO+dbXiK2lDe5hllej6fC/kO22U/f9R5HgeaVlgOo4jYlLba+BYWIUBcAyPG0u3SEkxGOeqGGwd
	74tvXbm5JRhsQQ9tFFCkmxfO/iXwMiU8cn4C/OH3FnmMWjUDfjOYgvphGodHmlo8vDoujyk2phZ
	Um1yaVXd50JA4R5l9knlyf46npW5qpu9C+RkDTj/oN62F1QX5+aPaewPD874y5a2gxRBb+Owl6I
	qBfdp092/Q4uKMg==
X-Received: by 2002:a05:622a:58c7:b0:52e:119c:e82b with SMTP id d75a77b69052e-52e4228d40bmr50824231cf.13.1787733736668;
        Wed, 26 Aug 2026 01:42:16 -0700 (PDT)
X-Received: by 2002:a05:622a:58c7:b0:52e:119c:e82b with SMTP id d75a77b69052e-52e4228d40bmr50823741cf.13.1787733735949;
        Wed, 26 Aug 2026 01:42:15 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25271e4cbcsm159514166b.18.2026.08.26.01.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:42:14 -0700 (PDT)
Date: Wed, 26 Aug 2026 11:42:13 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for
 RESX
Message-ID: <5ypfciwn2wavbfewlludahxsrhil563h2pspw33fvm53nxv5rx@6l6b3npaezkh>
References: <20260825-pci-pwrctl-tc9563-use-cansleep-for-resx-v1-1-0dbe7cfd8200@oss.qualcomm.com>
 <20260825115246.8C8691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825115246.8C8691F000E9@smtp.kernel.org>
X-Proofpoint-GUID: O4PLlyIZ_hoFQ9bGc9yVxKEARNDNSIr9
X-Authority-Analysis: v=2.4 cv=FPMrAeos c=1 sm=1 tr=0 ts=6a8ea6e9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=evFOPUGr5BWtyBnKTxUA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA3MSBTYWx0ZWRfX1EXoJq5tzaUJ
 64kWuKAj2bsKADYPa7t8RLahTjdr2jM6HRoEPBmin15zqbKdxcnF0HovMj1MVfwFS0bqFD8fjGA
 tk9YMXIqdUIRLY06kXogHqPoCaXxkKQ=
X-Proofpoint-ORIG-GUID: O4PLlyIZ_hoFQ9bGc9yVxKEARNDNSIr9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA3MSBTYWx0ZWRfX+cI3Z8L5vpM/
 47ldLL58qBMd1rKm0s6q2EDMZ2x/8WhwyhR/dOlv9COh7jD2X4fZI2WKtz24empLV4Dl1goGy0x
 W2HpobTQoUmhLtVPlD/P4/b9zKr+aI8v3a1GqrsxuGo9uKtkjbq9JcVUen1+MegC11zom6LcQVm
 G3c+ZxQtZfybdpW2kAGo9dsiIWfo0m/upralCeVPOckaFlCQ1NuK0EXrRyOKYA2ElFj275+c+mf
 6ZU7pfaHkDTbpxAAt3aUFIHcAUfGJY50Phebh1PQVi/uxV8XVIFY6oXHleTFkG1ljCQBiidixYn
 Kvw3lIyETuK+wUAgx1o2wqTepbbJMj8v5YPufDfJocpblUx0bWmCTnrhc3886EKORQR0ciJ9xhp
 mdRgorw5vp6XW2go+rEjvKT5WB9oSyV5n9bWy57oirO2R2x4KKiR1kgUYKhyiweSXrUJOF7qkoV
 IhdeBcD3Ztt62Y2XJjQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260071

On 26-08-25 11:52:46, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] I2C/SPI transfers during the noirq phase of system suspend/resume will timeout and fail if the host controller relies on interrupts.
> --
> 
> --- Patch [1]: [PATCH] PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for RESX ---
> commit cc5d1431bebcee3e75ac6e1b5150b5971fe40f41
> Author: Abel Vesa <abel.vesa@oss.qualcomm.com>
> 
> PCI/pwrctrl: tc9563: Use gpiod_set_value_cansleep() for RESX
>     
> This patch changes gpiod_set_value() to gpiod_set_value_cansleep() for the
> RESX GPIO in the TC9563 power-on and power-off callbacks. This prevents
> warnings when the GPIO is provided by a sleeping controller, such as an I2C
> or SPI I/O expander.
> 
> > diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > index fd53a7db9875d..1b7718d07d15d 100644
> > --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> > @@ -481,7 +481,7 @@ static int tc9563_pwrctrl_power_off(struct pci_pwrctrl *pwrctrl)
> >  	struct tc9563_pwrctrl *tc9563 = container_of(pwrctrl,
> >  					    struct tc9563_pwrctrl, pwrctrl);
> >  
> > -	gpiod_set_value(tc9563->reset_gpio, 1);
> > +	gpiod_set_value_cansleep(tc9563->reset_gpio, 1);
> >  
> >  	regulator_bulk_disable(ARRAY_SIZE(tc9563->supplies), tc9563->supplies);
> >  
> > @@ -501,7 +501,7 @@ static int tc9563_pwrctrl_power_on(struct pci_pwrctrl *pwrctrl)
> >  	if (ret < 0)
> >  		return dev_err_probe(dev, ret, "cannot enable regulators\n");
> >  
> > -	gpiod_set_value(tc9563->reset_gpio, 0);
> > +	gpiod_set_value_cansleep(tc9563->reset_gpio, 0);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but it makes a pre-existing issue
> more apparent by acknowledging the GPIO's I2C/SPI dependency.
> 
> Will I2C/SPI transfers during the noirq phase of system suspend/resume timeout
> and fail if the host controller relies on interrupts?
> 
> During system suspend/resume, the PCIe host controller executes
> qcom_pcie_suspend_noirq() or qcom_pcie_resume_noirq(), which eventually call
> pci_pwrctrl_power_off_devices() or pci_pwrctrl_power_on_devices(). These
> invoke tc9563_pwrctrl_power_off() and tc9563_pwrctrl_power_on().
> 
> During the noirq phase, device interrupts are disabled system-wide via
> suspend_device_irqs(). Because local CPU interrupts remain enabled,
> i2c_in_atomic_xfer_mode() evaluates to false, causing the I2C core to use the
> standard interrupt-driven master_xfer() rather than master_xfer_atomic().
> 
> Since the I2C controller's device interrupt is disabled, won't the transfer
> time out and fail, potentially causing a system freeze or suspend/resume
> failure?
> 
> This would affect both the sleeping GPIO expander and the I2C bulk writes
> performed later in tc9563_pwrctrl_power_on() when calling
> tc9563_pwrctrl_disable_port().

Duly noted.

Needs to be addressed separately.
