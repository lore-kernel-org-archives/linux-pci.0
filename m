Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BFB371D15
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 09:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779355121; cv=none; b=JJ7vnxp/Ocffr3C7IKbDEgQ+NTLQk3aun/R7FLrx7wRZM2IrH6FNPhdxgqxUtYAHG8XnWPrZj/brGfpxH155qRzuxMwCQMZ/v4weJMX8yAn0KpybXvaKz080My05i7nk+19dilKKPx7lGcRhLBNJ61jZyqV3Pw5es3RV5KOx2Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779355121; c=relaxed/simple;
	bh=azw12yvo1KzS4bOAY2lRlKmNg9Zna4MNvidgXEzteRo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNcBVEO54xKCHmej8a05PXNcg30Ue5PXtgfZ9oQYAuOHFjScgZoO4uE2H7UJDZwMqM8n8P8cETmsKC0/x2yLsXziz7CGTfKjQmq0UL+jvHxSYHVX8JA4qvT9EOckP0MXx0rBuLwXuYK3RbCQ78nq9R50igu2NKCeAk2uuW0ktcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZjKXkQZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZjKXkQZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3D11F00A3C
	for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 09:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779355120;
	bh=azw12yvo1KzS4bOAY2lRlKmNg9Zna4MNvidgXEzteRo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=OZjKXkQZv5hnNqa14eYjTh92IdTWlvwfWTIj7QQ6zZkUx4SgYVrNqah27+wXDgjGC
	 gWwVAF16Zx+3ZNyDxS6R+5KspgS41D1YJfszZPUbt2Md0a0LqzG7ynooFeMF2V31I8
	 76cf66sJHbi5RPQcIc7DKra4Ji2OrLpqBOSTcDvYsrXUd2yw0e3ApjSrnJNYq6TT73
	 58761eq7Ho0Sqkpuy5VllINNeKqtQSUBUGMhZN3puywZnymXRkvzVdipe1CKKmvPww
	 ynhSv0XuKxAeDdeMgEcZavvEKxm7PRzgtkeJq5LP6jnjJG3BcpNij4gUdTpNghCnTH
	 usyNtekRbqhxw==
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1357c851a48so6614709c88.1
        for <linux-pci@vger.kernel.org>; Thu, 21 May 2026 02:18:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9fpdCcnb0EGtsLQd8xVaF5ZS17QwIECjWLNQTM5Vls3DOHJVOCYuLq0r4FRlisjAjOnRoKMFyqtrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa1pq7CXotICw0UdNqDlmdW8zmzRXXWLbu49u8qi39YkyDc6ej
	OslNvza9TqEZK1mvoiDBbJsxFgkcAwkGzNkdXFgEUBQDOnsz7W80Wi+oNcudBprd12y3KoY4lq4
	nW5Opthsql7ihJ+Ai8RhNZabkhp8CJLGdPDVpY2YFNw==
X-Received: by 2002:a05:7023:b82:b0:135:a75e:7d93 with SMTP id
 a92af1059eb24-13632c2e98dmr919788c88.32.1779355119421; Thu, 21 May 2026
 02:18:39 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 02:18:35 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 21 May 2026 02:18:35 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com>
Date: Thu, 21 May 2026 02:18:35 -0700
X-Gmail-Original-Message-ID: <CAMRc=MdddNGkost=5XD9nvxwcCE4mRHQhAow9gS+Hap_b32mpA@mail.gmail.com>
X-Gm-Features: AVHnY4IBgnLNrnXiblCXaybZXjL6TZAv5y3zJhw560hCdBFpu5oS9qCU09vJltQ
Message-ID: <CAMRc=MdddNGkost=5XD9nvxwcCE4mRHQhAow9gS+Hap_b32mpA@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Fixes/improvements for the PCI M.2 power
 sequencing driver
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, Wei Deng <wei.deng@oss.qualcomm.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 10:55:55 +0200, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> Hi,
>
> This series has several key improvements and fixes to the M.2 power sequencing
> driver and also the BT HCI_QCA driver. Notably, this series allows the M.2 power
> sequencing driver to work with more M.2 cards, not just WCN7850. It also allows
> the BT HCI_QCA driver to detect whether it can control BT_EN (or W_DISABLE2#)
> signal on the connector and set the HCI_QUIRK_NON_PERSISTENT_SETUP quirk.
>
> Testing
> =======
>
> This series was tested on Lenovo Thinkpad T14s together with the below DTS
> patches:
> https://github.com/Mani-Sadhasivam/linux/commit/29534d15307551b2355eb254601dec511169f0aa
> https://github.com/Mani-Sadhasivam/linux/commit/f4eaacfe647674be200847092b43cdef2194fc55
>
> Merge Strategy
> ==============
>
> Since the BT HCI_QCA changes depend on the pwrseq changes, it would be good to
> merge the whole series through pwrseq tree or through an immutable branch.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---

Luiz, Augusto: this series looks good to me. Do you want me to queue the pwrseq
patches on an immutable branch or should I just take the entire thing?

Bart
