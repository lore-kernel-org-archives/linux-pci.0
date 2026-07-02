Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4DAC39099C
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 07:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976015; cv=pass; b=HwzCHjq6VyrjOn4xkpHPV2KLZDcv4uH1E3YTEjb34iLqNFpSCyEaYNaXl/iYSuDlwCSW11dt5exP6A6UzAb9ahc1YtoGW8qdD6odqHW/A8LkcJQi7MdEeztLgV6RB/kcO7/rcScf/e/B8FVhXQHt/ADeJoAqXTimTOAgT7xK5DQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976015; c=relaxed/simple;
	bh=C+0ASHQ7+sxEvG98WN4QO2iMDyb2Av81dAetWqPVHOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7r5XvZgloA9CDjYY24yLOfX6VSgrPPIY5n1YwyVl1W6GRJb82mAwwpTuvS+ObZ9yAsBMk2G8ktNP0hBXKtSz9kXneqyBYPYTLXBkMHPcPKJI/NrtSGA3RhyybljsUQuVT24owUUDBs7dGvA2md9NA0Yyfx/uBuIhIsPcNJ2vjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Akdbnxyt; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Akdbnxyt"
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A8AEF3F97C
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 07:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1782976002;
	bh=3zUCKTr7NNFz6SJWFCocGWq9Mhg/KJSSrGKGnz1wiJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=Akdbnxyt4CMomAuApn1P1H3eQ2yURdXzUkLD3FocFUJ9jSvnhgV1sRLPxKkqWwikt
	 Jc16m4plyHT9pBW+GJhx3veyozqZXH8NCe+HVqhM4f0s8dcYwVO5r72Pdu26WaJR97
	 vCK/6LNmeepWk6litjE7AjvB3pQ1CMhWt68hTyzx72euBlYhmhbbuFm7syMqoL218l
	 X7kURknKT6duhNu5FqpJMsUXvEHBQFj2oXVfaOtkpBKDsgkLi6ChFniZYQeqNJ/SLt
	 jIGFMuroGhrlU2+gfykGaS+R1qHwJcBSZThScDhgPkneXzxztCGkKI6fQ7jJxxeoFG
	 bDmDBq7mQtoQyZvkWUGCUzXm6Sy+ntEYWjXHcyKWyTqtackmz8/0JBJN3EUyg4rS6S
	 sVXe6o7zBNNAJL8p6ZjPSjlvb98vScKtT9lqGsqlX/hvn/IIFrkJmg1uYurz6pvcmY
	 h0qp7WGHjZk5Bli0JYF9fNbUuxJA9Qn4jV9eeHz1D4FNBBniFh8dfuGPNdOH3k70Km
	 CK0Q1cIIHVel8C/7qoa3V3zpzBAtfQjMo7yDhg+3r5tV9oL2JSJlWalsIbtoPBsoh5
	 LPqsMptHOjSMkRkK7Lkct/hPV+RyC78PSF6NjN/eyMsfNcbXEqHSlsSgfXrN0/EO8i
	 j50DUB6oEjh3dQdPYNbD6p40=
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c890bac374eso2021439a12.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 00:06:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782976001; cv=none;
        d=google.com; s=arc-20260327;
        b=ngLNJlOyBLzIIbefqodM0nziMSLm6KwCnOs6MUY2Jg0pyrKHj08oaQYPdeBd6NeXQn
         QaHwpCJc9IYFrtxIGzO/TyrP0TuGTq4Ychr9Aw0zR/+P1Lzw6KcvDfegpQOhyRI5SM2S
         gK/jAmblZIP8R8Y8Sx/+uX5l4edGa9g3ZwvrMiRLZ0QXthAZpK5tczrADzIzes49mRZ+
         M0F+sArae5Tkz5de9uwQvw2W13xh0sa7hLbcaC9+1XAM+wDf8QVRdpVlBa29Xr4oWHQV
         wjLoYrjPyki1zmyEMRhi4O6FyWicOq6tbQiW96hrwwkr8WlTW8AakNestypjKabdA78Q
         Co4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=3zUCKTr7NNFz6SJWFCocGWq9Mhg/KJSSrGKGnz1wiJg=;
        fh=z4ZpbZEAWShY+8rNZjmKsVto5AOpJyCTmnu/4IMQraI=;
        b=kE7/pM10zRyF88oqF0tYbd7jW9HV3KBcyNERMYUacrV/A/5ijQBo6E3qtQonuaeRFp
         khDiVsbESLKvgZJJBifFF7ooawW+h+lbst/7GdjB5D57oaJTcmCsERfrtyH8FClUbagw
         YKGoNYj8UN2+CioxjfhHMrEFbHae6yB7MYZhRBhHf+PfsCOJefXRjcIJJBXuDjY7VEyb
         KOyXgtbKfSwHlp8vYyF1xiheSE2Bv4jIoT1vlyvhB54+SqVxN62vZMV5c3t7IE4VkX0I
         PLtCfZrdar0SIh7xvBJslzaGrsSBfQraZBwW7vlUii98Fv0QcIOy7g6mClau8a8616Mj
         YisQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782976001; x=1783580801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zUCKTr7NNFz6SJWFCocGWq9Mhg/KJSSrGKGnz1wiJg=;
        b=L+ne5MhF3SqqsX3I2FRbDFjPKvjXR9MePyeQgCa+qiGBJXRpMJ1BI37sFxCk/URYhv
         17URXDwJJTG+22uTK9Nd4VPwwB4XeX98igoyM0Gqq4uumIusXTsUfD7Iks+ywb5jfn2G
         rFvPdG2VZITAdARQkA6b4Sx5LMy0S0c6qijUmLULPFzTXqdKu/hn+iEo6RZo4NzwRuPi
         O9RYwi+nWKoPOyYDxEiTFDN5il/GTsbB7pEawDQi1FrGPlawttxJQG3gqPiti/bHpPTR
         M6+hmVGnH+Aw7HkDDJhxrErwtM2aDZgD9AgDVFU2ahnG7sV2+FUSGYjnGQpOPBmcw0VK
         KQIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+lA9YP18dB0cKu1CffPsrB2WGtkLs6JUnQhnIF9D4m9mtmMxLk9fF+TpN/oPTzo6wQn7MUFG7Rmqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYsp8em/syJgPtx/Jz+BmlxiHMHFae6a5XtSFiJq7+25bwLbyU
	x/m34sx8aKWW5SuOEvMBonzUg4MTJqhMW7aYFFDvsCz96LfTFH50jUsqEZfg+knijmvS39QOZGF
	NF2nL/58zMQNQ4Up/SzdyxfnkdBZWqDUuTe9goJ832YahIb1x6IzeDYv3iOun58hW4acdvpl0qB
	h8BSE0DIrp/R2/kwfpwN4OxoRhXXb/9uZYjbmH3JFSbAiIZ4znNhZ36si42TmTG5E=
X-Gm-Gg: AfdE7cn1TfII3cncrn+bmuLCUzaPbeT+6PJt6zrXIkYjLYT/+V742icro7KBJAuQAC/
	dhtJ0b1YOCDlGy2PScbeVosrnWkaU/7GbJkViz45AjMIBJ36sr6Yor3/TZBP/rQlSScKUUcXy+Z
	NpkBL96mOBGC4F/GIThWYc36vqELhDVTA38ahTLfXLymgFQLNgkJCyGu0qv+laPBPNIRr7
X-Received: by 2002:a05:6a21:e598:b0:3bf:6c08:fb94 with SMTP id adf61e73a8af0-3bfed561dc0mr5869466637.54.1782976000990;
        Thu, 02 Jul 2026 00:06:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:e598:b0:3bf:6c08:fb94 with SMTP id
 adf61e73a8af0-3bfed561dc0mr5869423637.54.1782976000506; Thu, 02 Jul 2026
 00:06:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <oc3i3yn4c22s5c3gtqgs7a4wrpqiywwvboxstdf7josxddqmpd@y43m75ovby2t>
 <20260701204201.GA302478@bhelgaas> <akXy1gsijpfslOJm@wunner.de>
In-Reply-To: <akXy1gsijpfslOJm@wunner.de>
From: Max Lee <max.lee@canonical.com>
Date: Thu, 2 Jul 2026 15:06:29 +0800
X-Gm-Features: AVVi8Cdi5lH9UFaG-QZRS6q41KeROCwnaM5789DtIcxCtdUdtWKXfyXVMIUMJGg
Message-ID: <CA+YcyLx3XS3LEeVzPEfD+OdktsLFyLuN4mQGk9EyEgQUmKPLBA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: Mask Replay Timer Timeout for Realtek RTS525A
To: Lukas Wunner <lukas@wunner.de>, bhelgaas@google.com, 
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acelan.kao@canonical.com, 
	Kai-Heng Feng <kaihengf@nvidia.com>, Victor Shih <victorshihgli@gmail.com>, 
	Jon Pan-Doh <pandoh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 02, 2026 at 07:10:46AM +0200, Lukas Wunner wrote:
> It would be good to have full dmesg output for analysis because this
> is all a little murky.

Thanks Mani, Bjorn and Lukas for the detailed analysis.

I collected full boot dmesg and lspci -vv from the affected system.

The system is:

  HP ZBook Power 16 inch G11 Mobile Workstation PC
  BIOS: W97 Ver. 01.09.01, 03/02/2026
  Kernel: 6.17.0-1012-oem

The topology is a direct Root Port -> Endpoint connection, with no switch
in between:

  0000:00:1c.6-[58]----00.0  Realtek RTS525A PCI Express Card Reader

The log shows that OS-native AER is in control:

  acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME
AER PCIeCapability LTR DPC]
  pcieport 0000:00:1c.6: AER: enabled with IRQ 127

I did not find GHES/HEST/Firmware First AER messages in dmesg/journal for
this boot.

The storm starts after the PCIe port driver enables AER on 0000:00:1c.6
and immediately after rtsx_pci enables the endpoint:

  [    0.798443] pcieport 0000:00:1c.6: AER: enabled with IRQ 127
  [    1.057380] rtsx_pci 0000:58:00.0: enabling device (0000 -> 0002)
  [    1.057399] pcieport 0000:00:1c.6: AER: Correctable error message
received from 0000:58:00.0
  [    1.057405] rtsx_pci 0000:58:00.0: PCIe Bus Error:
severity=Correctable, type=Data Link Layer, (Transmitter ID)
  [    1.057408] rtsx_pci 0000:58:00.0:   device [10ec:525a] error
status/mask=00001000/00006000
  [    1.057411] rtsx_pci 0000:58:00.0:    [12] Timeout

Ratelimiting is present, but the interrupt/callback volume is still very
large:

  [    6.058155] aer_ratelimit: 120541 callbacks suppressed
  [   11.059227] aer_ratelimit: 120906 callbacks suppressed

/proc/interrupts later showed IRQ 127 for 0000:00:1c.6
(PCIe PME, aerdrv, PCIe bwctrl) at 940777 interrupts, while the
endpoint's own rtsx_pci MSI had only 6 interrupts.

Both the endpoint and the immediate upstream port expose AER capability.
On this unpatched boot, Replay Timer Timeout is not masked on either side.

Endpoint 0000:58:00.0:

  Capabilities: [100 v2] Advanced Error Reporting
      CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
      CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+

Root Port 0000:00:1c.6:

  Capabilities: [100 v1] Advanced Error Reporting
      CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
      CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
      RootCmd: CERptEn+ NFERptEn+ FERptEn+
      ErrorSrc: ERR_COR: 5800 ERR_FATAL/NONFATAL: 0000

So for this system, the endpoint does expose AER, and the observed storm
does not require handling the no-endpoint-AER case.

I agree that the v2 wording is imprecise.  pci_mask_replay_timer_timeout()
does not necessarily mask a Root Port; it masks the immediate upstream
Downstream Port leading to pdev, which may be a Root Port or a Switch
Downstream Port.  If I send v3, I will fix the commit log and code comment
to use that wording instead of "parent root port".

I can also include the full dmesg and lspci output if useful.

Thanks,
Max
