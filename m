Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FCE3382F2
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 12:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771330457; cv=none; b=Djs781oUd9LK2pYcXbwuWI27XGTH5UTvegBj+FeMfX2+AMiCc7TIK3+vUk4ZZDv3TZ0BJqaEG/urotiyPSdqFr4pg4kpBP79owXRR2zkBaYCu2DXTsn45J+jwlinBGBGi9iibht/Beg5qb0kNhDTF6ziPY7/QuRlpNVlSaneTgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771330457; c=relaxed/simple;
	bh=GzbMn5T9/MXDM9EdqOcMdMyDocYRlJZKEfhQcRM0W2k=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6COuQY+/KiEkXII41XBTmT5NctDLozDBvS8Lg+rB/fAl7KS6i9OtYPrEjdPU5SDR24MSFOqIIP0HZKVc1td6r1gqDoxaua7KdtT9rdPf4sL5wAJGe7aaPmvnkfVM2gtP9YxB9G5Rq0cxiGNueP74LR7abNnw45DV4BxvDUtQMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvutk4tU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvutk4tU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14C1C19423
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 12:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771330456;
	bh=GzbMn5T9/MXDM9EdqOcMdMyDocYRlJZKEfhQcRM0W2k=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=jvutk4tUlBqQgaFz9/xizPIuJaCGMt8LuhAFEZ0nzCHSFDQq2ibLtxAL33Nvj/Mkt
	 C65zLMArSY3YDfVB4C90mlfXcMNJNYxz/eR3N0AmEuVWzVCPAw+17zLQRmdXTKtH88
	 a+ncTd2Wl64bwPZ7eKuJZ8oMMJUc54toHUPqx7AgXmnT/bv6YpS/tG+o/Sum279P+k
	 koMEKpdYfO9yd7TtkB0tGvK7aIcl8iq+GMFY74Di1eDUOBHQiEypB/2NsN3RpwvWW6
	 FGTIyojGKQiwvoEcttQcs31TpU4H1P2HH/JnPKmcRtI+0Z7QVtA5f3DabhbBkiohTy
	 dH24+5C8FgjpQ==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e64657f0cso4031178e87.2
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 04:14:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3aqcCO5UTdyqHd+RRGezoxw1eVpZ2g/g/7hiU7K8oCGLr/+z9eZRXnGqsMvYRtcx2EaWVdVTrFPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRvzqEfHVuckC+WNsn3ZlZo6Ye6Em2xXY24dFeJNx9Y8OWR+Gf
	9gX0qLCig+X9rV3VuCg+iBoAt6K39/Jms4S9cjwqv4eDIVHNrwQf5hSjtCDJbUhpJsie1Zmu9BL
	7auqu2pDTfUAxK7SiHQNy0ujlp1qZtP9Hi9x7qNa3tA==
X-Received: by 2002:a05:6512:308d:b0:59e:49f3:656f with SMTP id
 2adb3069b0e04-59f6d354a78mr4196518e87.14.1771330455380; Tue, 17 Feb 2026
 04:14:15 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 04:14:14 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 04:14:14 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260217-pwrctrl-fixes-7-0-v1-0-b5671e58934f@oss.qualcomm.com> <20260217-pwrctrl-fixes-7-0-v1-2-b5671e58934f@oss.qualcomm.com>
Date: Tue, 17 Feb 2026 04:14:14 -0800
X-Gmail-Original-Message-ID: <CAMRc=MeU7qvWLggrDmFhUUYt9RJcXsxPhwHNagF2jb5tbPaWzQ@mail.gmail.com>
X-Gm-Features: AaiRm53fJBasmzqxMovPqkKciYHF7M1zzv4kxajhcG2fpngdQQwYoIo7_xgOLYQ
Message-ID: <CAMRc=MeU7qvWLggrDmFhUUYt9RJcXsxPhwHNagF2jb5tbPaWzQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/pwrctrl: Only create pwrctrl device if the device
 node is of type "pci"
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Feb 2026 11:18:47 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> The PCI host bridge node can have non-PCI child nodes as well, like OPP
> tables, USB controller node etc... So the pwrctrl core must check for the
> presence of 'device_type' property with value of "pci" to ensure that the
> pwrctrl device is only created for PCI device nodes.
>
> Fixes: 4c4132489201 ("PCI/pwrctrl: Add APIs to create, destroy pwrctrl devices")
> Reported-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> Closes: https://lore.kernel.org/all/20260212-rb3gen2-upd-gl3590-v1-1-18fb04bb32b0@oss.qualcomm.com
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
