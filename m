Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352290;
	b=VAPuwlG5YdwJ8EAZRqYPo/qOyAIeZnCIIeY4Y/MkAu/1MuYG3Jw08oEVCWU1wq4l6ILh
	 jNlOpAlFPs2In22k1u1tplYLbXG/MKT2SPs9RzBVa9GJJYm5AZreSdZ+tDCm4+uFtgC13
	 nkecj8ym32CiK+CweS55sJouX7q/nbGlBPBeg9WlhG7X3jjjKSSrZt29SsUu9e+lxmoPf
	 mNEebO4yOCDxxIQCAjdObW7FXiqQLMb5ZwPjZcHRsXPyxEZV96/uKc069h11ohmOHLGHU
	 s9DMXRsGQU/GVfMueeXc3vqgrWRW7fFvPi5yC/tITS/Mq73SvWkqDNX89gvGU+V0mFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352290;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RapgeB9lnSOOHM+Q+Ek+TouLYSIIJBsaMcxUoOZ7Uqg=;
	b=mgqVXa9ALYEHagUXi0J479+V1SvUsn1shsffGkFNXp7WwuinOkRK39tY8n3/U95KLVHF
	 onp4ZD4JcoKqmq2JMYnIXPDJsnOGu1+GD8tZxI7dKz6aImel1hII/vzv0ysQSIwbbEKmg
	 Oabz+wZ4g2HnFeB92jBtcX7XiffT6Bq3ctT7eXpFUbSqutrSTnv/60snZdHJNyxOncjbp
	 PqxDPODkue4EpGPJHFpSCyR7YG/E1KEfhdTSbZ7y8ylBBK8pcmSQo62LAPq3I5xl42knP
	 2eCE2PHi2swAiJeXyejEfgIX9ZlHJ6TEG2YjvSkr/8q0g6CIRxCRu54KM8z3SKK1AEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b="M9/OslpQ";
	arc=none smtp.remote-ip=209.85.160.173
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7236606A31F
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 09:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7236606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=M9/OslpQ
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-5364648ae07so4795311cf.1
        for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 02:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1793352289; x=1793957089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RapgeB9lnSOOHM+Q+Ek+TouLYSIIJBsaMcxUoOZ7Uqg=;
        b=M9/OslpQ2iWiPNnVacSyrTONqsDdV7XepJ8yNTeTlisIJU+N2zQzmJDwLU+wgcleOL
         +mOvyk8VBDCv3PnlITOWQdW/xntxHpXYuRjJP67kmBzXAelwgXQeSTPyfaeeFnbiI/fT
         5e9r06ZahMJDOskNQcXsiMSQC6pL1vPom0YVK9MxrSMufJ5svO1s/uSrtOISek/AD2aD
         ijkv1JKsUH3+sVoM4Qs5SU0H9HSHgdTAh6xv8nmSBVyYZi68SRM8sftAZNqwkixIXIXa
         5jtjyEbaQ/fd9qLwI3uXl0MEZHyjlGB7n+Okp3AWNq9Lrl8JBrxY87ECN/KNp00nDdzL
         eueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793352289; x=1793957089;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RapgeB9lnSOOHM+Q+Ek+TouLYSIIJBsaMcxUoOZ7Uqg=;
        b=zoChs+z/LvndugjYzkw2vtQ2WMia167bAR//BTx3OTezx3/q//lBmnU2MSyxdMOHLA
         Ojf/2aaSHUT2FvopbyvdkbN7xk6+Ky5wzO1IgcLgAYdaH+gj+SrrvZcZJdQdOfhxCfnf
         EJY6gP4EeN0rfScKzsaMG66Iot2l8mEps0q+27Ke5kK2mIpR/VDb2CNrYI0BLk+/KeYz
         ABPP4Du9E8ESWXM92GSrRE5PMrnUGrHphYyBAjj91hS4j9HbtfuO7Wz+Sf/nBDuHt4wj
         QbW/s4NPlrexUtDY/XuhbkV4LeT6N+dWxb7y1Z+GewY7A8jrTL/OrGwxsiel7W84Yvdf
         /K9Q==
X-Forwarded-Encrypted: i=1; AKwUvBwEwNqr0GNtfc4Aq7fRXqSiwi7NimWTbplHJrQYbwjE5yOCuZW7XTDDpQ+ODBc4KDlq+oiLUw3smAw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7i4KbQWj4emeAv/YeS0W+QEFckkmTLTGQcUaqxuG9IW8AgW/j
	TWgHzVgK45rHg15UtBR45nhIj5ZH2nPh34891l4Ukq3pju8Lg8bTlKT2di3MB9RnOg==
X-Gm-Gg: AYBFou1ARcI9abt6VZwVr/0UStUI9yrR8jkACZoxyeOpu1mam34auf+tEPqlI6jmehm
	ERZi7VkkGzUO28kAiw6K9EODZ8aa03kxJDnN35lHXxYkI1e+9AQtrDuVyKD+q3UL9geK13ur4BZ
	Pcc7TVpkqluuCVETlH/loNx5NhFYlEpikLR63I1wmu5Zfs65bJtGIihlR2nz9iMykanjsMk1xFl
	LOOpGwPMyj95823Dpz7x9W+LG64TygUPlePc59C/Asexm1kws8ImqarayoCxJjAlR8gnCETAdgT
	0/unwJXET8Jybc06VUhVtjl/YdOtzed1rdzTFIwyDbRAkzsHkh9hodDBiU6OZ9n8Og+Op5XKVW1
	qr432eudexsiVf0V63/qxAQiSYXZY8grk95XvscbSs03CAeE+RxzHXn4+xx1JKFlsxAcQ3ZDqsi
	tExmUaov1QKSCN8F4Ugiw/1vnTh8Q1S7CbqQpnytepyHkdWGyIis1pgwz47gaKzIXr32Cdh+Lvq
	wsRrjMeziPmgIb4t3dgCdPM0nmSS4kZ4F4OifS7sKyqY83+EjRmHx4tI13M24CF9SE3qkCDXodS
	6yZNHtod8I8iUHV28vxpGz384wK7hrKMNh+MFot461giFKprR5kL
X-Received: by 2002:a05:622a:1f12:b0:537:deab:afe0 with SMTP id d75a77b69052e-542b3e68d89mr22133521cf.10.1793352288578;
        Fri, 30 Oct 2026 02:24:48 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54311f775a2sm8848351cf.14.2026.10.30.02.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 02:24:48 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: tzimmermann@suse.de
Cc: x86@kernel.org,
	bp@alien8.de,
	mario.limonciello@amd.com,
	aaron.ma@canonical.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] x86/video: Preserve the default VGA fallback for legacy modes
Date: Fri, 30 Oct 2026 05:24:21 -0400
Message-ID: <20261030092422.300856-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4379fd92-ac4f-45c2-9f4a-eaabe4b7f981@suse.de>
References: <20261029162311.3389523-1-hengyul@cs.unc.edu> <4379fd92-ac4f-45c2-9f4a-eaabe4b7f981@suse.de>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Thomas,

On Fri, Oct 30, 2026 at 09:48:19AM +0100, Thomas Zimmermann wrote:
> Am 29.10.26 um 17:23 schrieb Hengyu Liang:
>> However, screen_info_resources() also returns legacy I/O and memory
>> ranges for VGA text modes. These ranges are not PCI BARs, so the resource
>> lookup fails and the default VGA fallback is skipped.
>
> If the BIOS booted in text mode or VGA graphics mode, the rsp device is
> still the primary display device. So the current matching code is not
> necessarily incorrect. (But also not necessarily correct either. :)

I agree that the device is still the primary display in text mode. The
patch gets that from the vga_default_device() fallback, since the legacy
ranges can't be matched against BARs.

>> diff --git a/arch/x86/video/video-common.c b/arch/x86/video/video-common.c
>> index 8ed82fff7638..b8f83346dfe8 100644
>> --- a/arch/x86/video/video-common.c
>> +++ b/arch/x86/video/video-common.c
>> @@ -45,7 +45,7 @@ bool video_is_primary_device(struct device *dev)
>>
>>  #ifdef CONFIG_SCREEN_INFO
>>  	numres = screen_info_resources(si, res, ARRAY_SIZE(res));
>> -	if (numres > 0) {
>> +	if (numres > 0 && __screen_info_has_lfb(screen_info_video_type(si))) {
>>  		for (i = 0; i < numres; ++i) {
>>  			if (!(res[i].flags & IORESOURCE_MEM))
>>  				continue;
>
> Further below in that code is a call to pci_find_resource(). [1]  Why
> does it match with vkms?  Vkms is not even on a PCI device.

It doesn't match vkms. As you say, vkms isn't a PCI device, so
video_is_primary_device() returns false for it at the dev_is_pci() check.

The problem is on the bochs side. In text mode, screen_info_resources()
returns the legacy VGA ranges, pci_find_resource() doesn't find them in
the BARs, and the function returns false there as well. So no device is
primary, and fbcon stays on the first registered framebuffer. In this
setup that is vkms (fb0), so the console is never remapped to bochs (fb1).

vkms only makes the console part visible. Without vkms, tty1 has the same
size with and without the patch, but boot_display is still missing without
it.

Thanks,
Hengyu
