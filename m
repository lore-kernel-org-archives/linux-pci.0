Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC7528C2BF
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 16:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776961446; cv=none; b=Fk/M2pBy7f8x4gWQHq+uPWOe2n+WjPEaJlScsx9zAaUPLnIBxwoT0eiEIzWTCz+0cnNv03Rc+fiAZdg+50LfZkYx0kBmxGBkcgyOhn5Lj9YATsufoMtOvXodFokWerrCrLrmQgA88hrpDd4jW2wX+OXCQablShBCacPYBKaZ57U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776961446; c=relaxed/simple;
	bh=U+KFmt95aVCklt9f5liT8xPIB/iXLBQ9X5Y2xAA1h0Y=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WhpykY+qXuKXe9laOv/kJQX4pHTSkmBLQ1rCnTInuuErA67IZk+G7khKR7zNTRSeFUIC5DlEvvs1Kwu89Sn7HdwewTg0aADwpRKhQ0EOvrd0sSwrBmQuhVOsKiAZRtMFyGyBHI/tsnJesXcDatCAoXGiUhSDkJdvRDL9eDYYksw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS6W89vj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS6W89vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA1AC2BCB4
	for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 16:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776961446;
	bh=U+KFmt95aVCklt9f5liT8xPIB/iXLBQ9X5Y2xAA1h0Y=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=nS6W89vj0JqAP+zMKZnxP9lt6XnAIW+wpC2dm/vaVq/mMjJdNKZn4ttFFXdH/0+IL
	 uq6I2vCb9GKfgA9QOx1nQAc3Bx/zxcWPOGW95zw+HAxpTEF+Yx3g4w+gwhxiErrM6R
	 e2mnVXE04VBQWzcr21THDTTJRzx/e7aJL0VF1hipnEMCPZO42ADliQ21FQaZLkVpIx
	 otyvBGs2myhIt3NuncqRZ6be8OhC8/OTFIyhA02tsBP+DZK3LwAfmESP0o6pzYR94T
	 IfnFave+z7R8VYKilC+ZSi1djW0Uo+uafXCm2bvl3Kh5jYpr4Wwu7mzbbXwIryk55Y
	 XC/K7bOvyhWjQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-386b553c70eso56320481fa.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Apr 2026 09:24:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9qLFX5tiJ8UD3610Z1R16TzmNPNVoWC7Xf8IzsZJOQWPEsW2XKGoGUGXTaANKFoDcK3gsPvv+KtaY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/+q8sCgwtr5JSmoRUnUDWAvkravSDk1AFqELPj/hFagQw1RB+
	ep6i6VLkxK7W48vYlbMxkxDNdE3xsLQ8qUIim7bABbtqckZyiue2IfM3IelJsxNZ9ibTIDAiDUt
	bRT5gtLfipNBSkGtJkoa3D3Awwm5TtLPMDTMGOOjcLQ==
X-Received: by 2002:a05:651c:23d2:20b0:38c:594e:ffd4 with SMTP id
 38308e7fff4ca-38ec7af20b4mr66586491fa.25.1776961445086; Thu, 23 Apr 2026
 09:24:05 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Apr 2026 12:24:02 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 23 Apr 2026 12:24:02 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260422-pwrseq-m2-bt-v1-1-720d02545a64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260422-pwrseq-m2-bt-v1-0-720d02545a64@oss.qualcomm.com> <20260422-pwrseq-m2-bt-v1-1-720d02545a64@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:24:02 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfCprFY4QCwEJzbBnROGJzrRE-sRAD89xDxsUsJVfqOiQ@mail.gmail.com>
X-Gm-Features: AQROBzCFPeFFKBDUBTFbF_d8cAOg-aBLOztoD_JeOpJg9Ts6CIUwK_iUG3b0JI0
Message-ID: <CAMRc=MfCprFY4QCwEJzbBnROGJzrRE-sRAD89xDxsUsJVfqOiQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] power: sequencing: Introduce an API to check
 whether the pwrseq is fixed or controllable
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Shuai Zhang <quic_shuaz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Apr 2026 13:24:42 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Introduce an API pwrseq_is_fixed() so that the consumers can check whether
> the given power sequencer is fixed or controllable. This will come handy
> in situations where the consumers need to know whether the specific power
> sequencer like 'Bluetooth' can be controllable using properties like BT_EN.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>

I have several concerns about this new function: its name is very vague and
doesn't really indicate its function (how is it "fixed" if you still control
it?), it can be used to expose all kinds of things because of this lack of
precision. I feel like it goes against the goal of pwrseq which is to abstract
these things away from consumers.

The problem we have here is for now a HW quirk affecting a single driver. I'm
thinking that we can live with this driver just checking the relevant property
of the provider device.

Many subsystems provide functions that allow accessing the struct device
associated with the provider. Could we introduce something like:

struct device *pwrseq_to_device(struct pwrseq_desc);

that would return the address of struct device associated with the provider of
the descriptor? It wouldn't even have to return a new reference as holding a
descriptor already implies also holding a reference to the pwrseq device
backing it.

Then in the bluetooth driver you could do:

	struct pwrseq_desc *pwrseq = pwrseq_get(dev, "bluetooth");
	struct device *dev = pwrseq_to_device(pwrseq);

	// Big fat comment stating why you do this
	if (!device_property_present(dev, "enable-gpios")) {
		// do whatever quirk is required
	}

Would that make sense?

Bart
