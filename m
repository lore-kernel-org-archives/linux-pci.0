Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22D8372663
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778499285; cv=none; b=eISytCHZ/nElSOWkTUie0bIhMd2k4R4nTadJwG/E8VIMgr5qwG19KoRAhzU/3P21p4rdiusbvqra2DSNWIO8+TWBtEdQ4CEndQC9gOFBLOqhK6l02VRTZ4+x9mK11RCwb9O57SJmeu4H8RCHH9N9NsCps83t/9GcN5IUKQchZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778499285; c=relaxed/simple;
	bh=u/rO97GV6xIVvGPFxWf9uNLpL6SfF9y57ZKNbS3WREw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMRcgLbc/UGVNG8rLG5wgXb/wnocqmFa0X7+I/YkcGRiAJHZVUQB1+GaZLgw30vylafuIjDMBSgjRivjJTCF7xA8xtbcaINuptn5FCoFmHppnvrjm+kjWNldHKj0c4bsywqxC1LlcWIgiQhuKdVrjEqMG8aV4E87rMLmVLa38iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6xxq2N0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6xxq2N0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78BFDC2BD00
	for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 11:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778499285;
	bh=u/rO97GV6xIVvGPFxWf9uNLpL6SfF9y57ZKNbS3WREw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=P6xxq2N0GnxCNtkGfWuYp230OmxpZmt7XAGGhj4uZW7P7rvyk98AFcw87AYqJ49KI
	 X3zD1PuIEPrEuKmbXetuRoKiz5AwcgvB2NiMmCz9oAuPvmvwuKpa3TcaMq4qpUFCLh
	 7iZ3rsb0YmlC4HQKKNKzWfZC1V+UdfVMkSV2doH3nDdLCvjSlBDuPRkKj4YWz5INDc
	 PNevJbqrtF04ZIJeBlCYGw3wlFhxDXzKdngF4wtOe+Tgh4H3iCCa8LO5NHTjUwUp3d
	 t7HiLRLJnuHqfyM2UXOaNF24HDbVBRsHS17JnL5ghN5nlxs1FfDK/zH/40dD0dhtBh
	 aCzyccJ1BMLBQ==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a884815606so4130791e87.0
        for <linux-pci@vger.kernel.org>; Mon, 11 May 2026 04:34:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8F7q0q9wosL98Bo0Cv8C9Zig0l+Nu3+AXJvt9CKewumCMXkWh9W0P4lxOMknwCBBmJjUGjDg5vOgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIkZu9zC4/jI/eVh+KDY6OUfA1JNNZsEitPs/1AhOL9yltbM5
	zyjCfTgiojBAWz7ZWl2C7xBjbWxs+6IkVK6bex20kzB+SzBn3SeoNvw1xb1FnReDSFwTiIJCTl+
	qT0HQUmabCsWNMQ8qWEVGXar/LzXTeoEAoXeZzwjHtg==
X-Received: by 2002:a05:6512:1595:b0:5a8:9988:f1cf with SMTP id
 2adb3069b0e04-5a89988f332mr7709402e87.31.1778499284173; Mon, 11 May 2026
 04:34:44 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 04:34:42 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 11 May 2026 04:34:42 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260507-pwrseq-m2-bt-v2-7-1740bd478539@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-pwrseq-m2-bt-v2-0-1740bd478539@oss.qualcomm.com> <20260507-pwrseq-m2-bt-v2-7-1740bd478539@oss.qualcomm.com>
Date: Mon, 11 May 2026 04:34:42 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me7=Mf4U1macJUzhDAwUcXjqSu6K3joACTECnpEoVFNjg@mail.gmail.com>
X-Gm-Features: AVHnY4KQwXOFJbCj0Fv2Swf6-OmzR6j41Xy0gf4jeamGfJl8dk0MuxJXia1DERg
Message-ID: <CAMRc=Me7=Mf4U1macJUzhDAwUcXjqSu6K3joACTECnpEoVFNjg@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Shuai Zhang <quic_shuaz@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 18:06:15 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> 'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
> GPIO in devicetree. But the naming causes confusion with the new pwrctrl
> framework.
>
> So rename it to 'bt_en_available' to make it clear and explicit.
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
