Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20123C3C14
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024979; cv=none; b=uPW8j+Xg08wQGWcx2ccYKvhk3ByF0xsoiJVM39tHhiu9ZeHIWR9JLmlJIJcCL9axEMndz6bFWe4vG6xNb/0U4co8F+ZmnKLSd3Cc6MPwIvl1zlD+mq5TToVkxxovGrK+AvIespZ3meROUfqE6/km5WaJpsQ+CnvY7yDK4ce+AoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024979; c=relaxed/simple;
	bh=WWAHEPstEIU7v750SQBStFqCd+u3jC9qRAxxv3lxRcU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx+jW9ClNDqo9xC9HnB+P98p1mVmHM8AXhjAGLrKoQTFfpiI2cAcm6ivMuvcaQuJ5E/PcX9l0RRj3Gi8pgNstquM+QDcalG3awT+LDh6DFJjogbgRv78oEGOjZ3vBVJOMcOia6OtVbco6h58rc5rsJ6Q9njGXQowIsa4Mhkd7s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQL+xQ6v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQL+xQ6v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2094B1F00893
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 07:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024969;
	bh=WWAHEPstEIU7v750SQBStFqCd+u3jC9qRAxxv3lxRcU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=jQL+xQ6vYxhiPdP046X9u6kHrppXoaJnzDrE2EK0DEBpE/kqv+ezgV5ZhhPq9w8Y7
	 pqxy8DPJPuBmlqA3cnOodDD35WiDukCTIo8oh5pXVrhKheFDeBigjPGL0WHqIW/FiS
	 joUtW4t8/hWo54ehxeLnKSmRBMAO//y0vLBNpBbmaIhjLKPT9sC6KsAH2jC+pHMm59
	 U+F4YL1C1VBd2jBwTEu4NigTobfZXaoZjRplHMuua/8jxLaQ8p00cHSo8acMAow32j
	 n0pCs1lxRxukBiq5DgJ+z4FuVWK1uNYKokCaNEZS/HhLGZGuIicyU2aowjwAYXSZi3
	 69XvvKy4bFy9A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b4a9994c20so656106e87.0
        for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 00:22:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwa+WgfKARKaCMfJrl7SjYh6yO37YzN9WhNoX5vKjiy/E3OmkNOMBDq+eZZ7T+o2EDhf3MjKniQLxw=@vger.kernel.org
X-Gm-Message-State: AFuF++m6vDTW9e1DzuMxKpjvUARf/I2l1TtoNqOWE2dxYC9S4rvGcgzZ
	VUG3DjaGJLVGUKHTaheyRramK1QFETStQrKBVxz1EYQDhDrPP934B3oblvrSGZbBpZSQbXXM8VC
	H+aXs+dS9mPcI3AxKLV7rmMVVR6BKBc1JMuAet6Ni5A==
X-Received: by 2002:a05:6512:3042:b0:5b8:99b1:4889 with SMTP id
 2adb3069b0e04-5b899b14a1emr841554e87.57.1789024967818; Thu, 10 Sep 2026
 00:22:47 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 00:22:45 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 00:22:45 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 00:22:45 -0700
X-Gmail-Original-Message-ID: <CAMRc=MexeyRRSy_x5bMNQDHecsFP_YxkjeH0zbaJ8Ngq2SAH_Q@mail.gmail.com>
X-Gm-Features: AcwNN1UrswOB9ZV6ZedluELrEbpjyEfv0uO0dNHGpXweDAO_Q3ar2adEbAhj8cI
Message-ID: <CAMRc=MexeyRRSy_x5bMNQDHecsFP_YxkjeH0zbaJ8Ngq2SAH_Q@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Power off child devices on power-on failure
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 9 Sep 2026 17:28:29 +0200, Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> said:
> pci_pwrctrl_power_on_device() recursively powers on the child nodes
> of a device before powering on the device itself. If powering on a
> child fails (e.g. returning -EPROBE_DEFER), the function returned
> immediately, leaving the sibling children that were already powered
> on in the same loop iteration enabled.
>
> Since probe deferral is a standard boot path, this leads to unbounded
> regulator and clock enable increments across retries. The error path
> in pci_pwrctrl_power_on_devices() only powers off the top-level
> children processed before the failing one and explicitly stops at it,
> so it can never clean up the siblings leaked deeper in the failed
> subtree.
>
> Power off the sibling children that were successfully powered on
> before a child fails, and power off all children if the device's own
> power_on() fails after its children were already enabled. Switch to a
> manual child iterator so the failing node can be tracked and its
> reference released in the error path.
>
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devices")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
