Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA0A1A6839
	for <linux-pci@vger.kernel.org>; Mon,  1 Jun 2026 19:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780341384; cv=none; b=rJ3S/E64rpqLFZhkB/orQUwefjadg5YsLDXbY41I2GRISsN2eDBKb/Vl3FYLFZEpHJbSVZ//ab+mmMbVRMB+X3xvsEo/cQ9xYUhNkNUBQ95TZLWZ/U/JLDxEtmcxqoZ3B3vpSt39yjAvuASISFSC0HpHQbCNPrJGIGQijqPkMfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780341384; c=relaxed/simple;
	bh=pfzOzaqWA/AH3npRNvlp0MxpAD4DF0Z7Hw40WYdOvag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XXIHzH9ovaVCTzc8sPcJRSaRkAZqwSsgukVHRxXAJ8zKGQU2fEaLGxqiSzgaGqdR6cR7Rtol9iKYRuc7JTmie/RSeIiLfuLAn1Y1SuoB366xCXqgXFAbvdf8fSFt3Ka47YJrQqJkDahHyS/AkG34oKeWyARAOjYVLvEZW9FPMHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=myfmX6/d; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="myfmX6/d"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-304cf518c9dso6728498eec.1
        for <linux-pci@vger.kernel.org>; Mon, 01 Jun 2026 12:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780341382; x=1780946182; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YY0AKjuRmhN5jXS67K9oBDfInraYXWkuQQvtFh6y0A=;
        b=myfmX6/dok18af1IkfDaIQnFS4k6cfp0IZpwppNQTbz2Z63pDdrnH9ZyaTJ7Yj5udk
         hxaCijVoQBFOiVgfLKLhxKMWMtdAM1mKoT3ibWlEXa2/Z65EC74baiSCI/GB0ZlnCcwg
         UPiGVTOlda3krVqKEUqHlDgrgipPhmNZUQ2Zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780341382; x=1780946182;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YY0AKjuRmhN5jXS67K9oBDfInraYXWkuQQvtFh6y0A=;
        b=MTVrvlG/DtiLTD8x87PFXtkMuQAtTe6uNhbH2sIbiimndAzDh+kdXXDFJ/a2xs2tcO
         UG3wBYXzLYiAfmppA9DZQeuL8FDJ2h4/uAGknBj7093wd/3UMHCPtz8vcMLrjpAHbqaS
         kg74PYvfJA/AH/HSLIQRs1MAqtv3S+XfwOWfR3xUHWzqKxCOn4NhjSkufdOzXQ1vqpJb
         aCmE6XM67yP7aCD8bwg/5yywQlcMEuI3sTK+dGcFGs9xCvYbZxafnAkPJV/i9wgvr4r2
         /Y4dMcMvRLseG37fLDpqUaQhNCpcZMiqRHrJAF/FJmsJ2KtYzhvOs/H8G/RwJjcWn3fT
         OqiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ZM3Kl4IkpsXsNHBSr3QM1pT2G/YRJu3ddWj67FvMrzbbhtFG8yIJ3sjDFW6WMiMA2kp36gFOcBhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJeTgl9Vbm0QCJljnV8WochffnV8JNAFdm4Tk+MQjehjApToAB
	kAkgMVEfP3S6g07+pG5KORjfn49fGLl/S859C6FQvUTNKPbnEciB2pS1NkH5osonvOWQzSl8ydK
	um/U=
X-Gm-Gg: Acq92OE5a+UkT21xn+XQFUsWP3XK8bQqm7DsseyurEaEtQXH4ynGajlHgczO4BF9QZv
	XcF3p+K1DSRh36wu5N4Y6q7FfCgcXfttob7EY3mxnYLOowu5glP6Qan3OEGMT+9dbDzePBpMDSN
	9gGwAMEHe1vfq++dVX8F74T8BwdHgbn7CZMbBy0tHbXpWT71c5sZe1sVyVNrqEYtM7mLfYmuuLd
	oL8HLMfhBVAeIpwf7SpW0hpG4fbJjT9SuYLn74Vxj5IBASpnybkRNvsonp8UTus+M95vf9GPnyB
	sPgPNI8T5L8UpgrFbGXnSHJa4UvA7G0QcnF9L2T47Dx7vNDyJWnzpPfxjXEHCNrJ2AbYCDAF2ib
	/vik4cqDjPghr9u7Lpf9Zy12BPyHy4ExAlBzTtbAafiGY+j9YKSXKeLgqpJcw7PDXcquCL/DqLD
	5Eeu9vPT08kg2/ebO5X67ZfrFrInymwXkcR1lX1z4A/3YNeeH8GUiHq/noeYSeUjylRz2mr9sL
X-Received: by 2002:a05:7300:ef83:b0:304:9b48:53da with SMTP id 5a478bee46e88-304fa6438afmr5420329eec.26.1780341381977;
        Mon, 01 Jun 2026 12:16:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:d53d:3040:2c80:7717])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-304ee0dd8e1sm13033848eec.21.2026.06.01.12.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:16:21 -0700 (PDT)
Date: Mon, 1 Jun 2026 12:16:18 -0700
From: Brian Norris <briannorris@chromium.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 0/4] PCI: Introduce pci_suspend_retains_context() API
Message-ID: <ah3agpwmcDfn9plX@google.com>
References: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>

On Tue, May 19, 2026 at 01:41:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi all,
> 
> This series introduces a new PCI API, pci_suspend_retains_context() to
> let the client drivers know whether they can expect context retention across
> suspend/resume or not and uses it in the NVMe PCI host driver.
> 
> This new API is targeted to abstract the PCI power management details away from
> the client drivers. This is needed because client drivers like NVMe make use of
> APIs such as pm_suspend_via_firmware() and decide to keep the device in low
> power mode if this API returns 'false'. But some platforms may have other
> limitations like in the case of Qcom, where if the RC driver removes the PCIe RC
> resource vote to allow the SoC to enter low power mode, it cannot reliably exit
> the L1ss state when the endpoint asserts CLKREQ#. So in this case also, the
> client drivers cannot keep the device in low power state during suspend and
> expect context retention.
> 
> And these limitations may just keep adding in the future. Without a unified
> API, the client drivers have to implement their own logic which may cause code
> duplication and may also lead to drivers missing some of the platform
> limitations.
> 
> Once this series gets merged, we can extend this API usage to other client
> drivers as well.
> 
> Testing
> =======
> 
> This series is tested on Qualcomm Hamoa based Lenovo Thinkpad T14s latop with
> NVMe drive.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

FWIW, this was already applied to pci/next for v7.2, but I'll add that
it seems this resolves what appeared as a regression in v7.0 for me when
using a Qualcomm SC7280-based laptop
(arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts):

report: https://lore.kernel.org/linux-pci/ahC8Pyuatu_AvnZp@google.com/
test notes: https://lore.kernel.org/linux-pci/ah3XLfI7E39B1UPh@google.com/

In short, my NVMe failed to resume from suspend-to-mem:

[   58.384442] nvme 0001:01:00.0: Unable to change power state from unknown to D0, device inaccessible
...
[   68.875606] nvme 0001:01:00.0: PM: **** DPM device timeout ****

Notably, this regression bisected to commit eaf290c404f7 ("PCI: dwc:
Enable MSI affinity support"), though I'm still not quite sure why.

Anyway, for $subject series, I'll provide my late tags:

Closes: https://lore.kernel.org/linux-pci/ahC8Pyuatu_AvnZp@google.com/
Tested-by: Brian Norris <briannorris@chromium.org>
