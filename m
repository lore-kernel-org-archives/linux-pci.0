Received: from mail-oa1-f67.google.com (mail-oa1-f67.google.com [209.85.160.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B645C382292
	for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 21:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789249494; cv=none; b=a3+4K8xUyaUz1A24VWOuH+HMqIVTo91eIdrMNKsg/rzuaBm0qSFKovrv9y8pOsMW2rWMKbnRqn3REbJMp9qOi0IvAGkvbdPAM7+NcEUJCMJDLyWoFmaS1v93HVSP+gsVbNpnbE/bJZbU1YXNpSbLrywbF9l58sFXBaQd7ewLIk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789249494; c=relaxed/simple;
	bh=kecUb0pDwLA3hY9/mqgnFWz1AIwI3Kabqzm0uxvNC3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAgUemQhdONtIVkbsx83tAy8DWJqVgldR557CfirNguueMN++2V3bQHvpxr9o+pajjxQvokhEZgSDg1YwOnXGUYS1Fil972lJEgwqDkAPbemIBzJGF39yiwheqIKMT6MOE/L292ibwP+Pc4Lnh5G8oqV4D22aV6EtDBrJRY8nYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UT/ehlUK; arc=none smtp.client-ip=209.85.160.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UT/ehlUK"
Received: by mail-oa1-f67.google.com with SMTP id 586e51a60fabf-46ac530b9ebso1602509fac.0
        for <linux-pci@vger.kernel.org>; Sat, 12 Sep 2026 14:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789249491; x=1789854291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HhWhTVqsOkpUdCAWPzbi+pVqLfh+oq55gUD464xfMJg=;
        b=UT/ehlUKiXKL0Z1mhtYHh9tv3SrIK488nAFPWA4XusbWDpLxUAqAu62tLcKcAP4sjM
         rfJNefj7Lh49C3Tk9HWCm+fHL3rJMfU8sPY+FMlKx8Zjg1YX7f4Jz4JDKoWa5v/UoVeV
         P5luHM4ER618xOSMHGDWqEDzzFaXlq7k459EE/Q9ZgEsGZyaDN4KH89g8/MqaMuZP5si
         lGLfV8p8pvX+Qxyc8QZf4hnH41Darn8ogmTalIjdLmdPr3smcOr2uFw53wUQP3iuRsQa
         48jWCAsgXMWgnMWKl7QNZNdz+D6Q92y3RyjWNFhi0d83ECDYxbyTGZCp3JofxDkWs8tb
         ZE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789249491; x=1789854291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HhWhTVqsOkpUdCAWPzbi+pVqLfh+oq55gUD464xfMJg=;
        b=KOOH6LGqBDKOHpXo0JYllOSgQT4flcqfhSRsg3eY/m1ap4dos75A820UDUH1mhOn84
         FECEqrrcmpUjfNpFDEcK/bdGSsvnOFJtHpfNKPsjweswkxm1j89coDoQS2IUdMZgULnT
         MrqkgASQd/39e74eV2HjY6L9HYR/KY13xOA69IUsoetarH2N1m/hcoNnp2fXZSAAPkPs
         S2ifxrVREJFNXqlzaoaMIZBf32Vtt8j0CbNPjacYTwD+RX2y29cvyG9vqH7cNhzdrcED
         wMYGovL3/jaPMIdjGa51LQBJcaUijfiPiLSvIIhF3ZxTHYSUfLF9A2m9Wzd5EN1zIf4A
         TXIg==
X-Forwarded-Encrypted: i=1; AKwUvByBHG+CqAwXd7eULwhO3v1qgCAWKB1ozPskSnMEwr8qsU9QD65V48edgC28O4yKwZc9FX24tRjEXNs=@vger.kernel.org
X-Gm-Message-State: AFuF++mcpTzZGAwUydTLAdQxrT8YT1l9JuuwnCTmtXnGbRLsoEG2/+bJ
	eCYankHfLGU52LMOzdrF0lYf7t61EX0qwGA7YOoOw/867d4oqXXJAxlT
X-Gm-Gg: AYBFou0gj53jejKubh15mWB7yaWerzUsRzrE4kY4216+czcEacsqkw7SJTvSqVbR+e2
	zcR9NmSTYwe8GEGJGzIvQcVbQhC8IornnKzA0MZe/OsLDCojeUxMCq9e9JkVfVWSgeEAbEfO9jZ
	7jbQDEmc1Gr52oOPIAaZL6Wdn9umnH3+DLdRRj3F9O0WfjDIWBpkrpdrN/0vLYbh44p0GJDPuLX
	MEFx1gn4zPfs2D2ft587JyOK9KqdDKB0Ou3gTGboa7BmP1RW1f1fsq7ViGZrAuqzR0HOTMGIcYn
	/B4GqDUVE1oYTrUI2QCxLwMs2E3Io9budwdsSiYNuqb2/5hN5PkdB6L/sBkFA3LdQNMVPAE0dh5
	lvGnHeQRZWkFtNeixSTdld1t1b6INhHe/pTQcfdAOAV5oWLAGR403ZgMVhhq1FGQOH+neQGM87Z
	YTsrRoy7zgfwEMaxgJghUmhTQmYvKu8ICbDHL6y6JQXybXiF+fn0Eb9cZ7TIBjcBcskDzVK3s4f
	SWHYYuC0G/NMTLS5CmqKQR9h+E=
X-Received: by 2002:a05:6870:e89:b0:469:fb8a:b5b0 with SMTP id 586e51a60fabf-47c978e0ae3mr8164063fac.9.1789249491570;
        Sat, 12 Sep 2026 14:44:51 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::c389? ([2600:8804:5716:d800::c389])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df42b4699sm6246514fac.0.2026.09.12.14.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 14:44:50 -0700 (PDT)
Message-ID: <688b15d1-a85b-492e-ba1e-b4da548ebd06@gmail.com>
Date: Sat, 12 Sep 2026 16:44:48 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci: Add broken-GPE quirk for Lenovo Legion 16APH8 and
 16AHP9 Nvidia GPUs
To: Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, Timur Tabi <ttabi@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, stable@vger.kernel.org
References: <20260821200607.621341-1-lyude@redhat.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260821200607.621341-1-lyude@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/26 3:04 PM, Lyude Paul wrote:
> On the Lenovo Legion Slim 5 16APH8 and 16AHP9, the firmware appears to enjoy
> firing a GPE on the parent PCIe port of the nvidia GPU very shortly after the
> GPU enters D3Cold. This means that every time the GPU is runtime suspended,
> ACPI firmware immediately wakes up its parent PCIe port, which then wakes up
> the GPU. Once it falls asleep again, the cycle repeats.
>
> See: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
>
> Note, this bug doesn't require Nvidia's driver. It happens on nouveau and
> nova as well, and it even seems possible for this to happen without any
> driver loaded.
>
> This seems to simply be a bug. Luckily, there is nothing that we actually
> need ACPI wakeup events for on the GPU. Events such as display connector
> hotplug events in D3Cold come through as ACPI_VIDEO events which aren't
> affected by this quirk.
>
> Reported-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Co-authored-by: Ryan Brue <ryanbrue.dev@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905
>
> ---
> V2:
> * Don't forget to actually use parent_adev with acpi_remove_pm_notifier()
> * Check if parent_adev is NULL (could happen if booted with acpi=off), just
>    consider it a no-op if it is.
> * Base the patch off Linux master instead, I based it off drm-misc-next by
>    mistake because I'm too used to working on DRM drivers :).
>
>   drivers/pci/quirks.c | 79 ++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 79 insertions(+)
FWIW, this has been tested by me, with positive results, on my Lenovo 
Legion Slim 5 16APH8. Not sure if this warrants a Tested-by trailer 
since I'm a co-author, but just in case.

In the thread [1], we have had another user report positive results on 
their 16AHP9 (note that Lenovo seems to have switched the P and the H 
around for the laptop one generation up for some reason). Said user 
tested on both OpenRM and nouveau on top of kernel 7.1.10.

This means we have tested 16APH8 on nouveau, and 16AHP9 on both OpenRM 
and nouveau.

[1] 
https://github.com/NVIDIA/open-gpu-kernel-modules/issues/905#issuecomment-5444071160 

