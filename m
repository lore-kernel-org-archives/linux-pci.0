Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6450C39659D
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410143; cv=none; b=NAT3SuVslX93j+tN3MzcOVD/ZwbyJn9UERt1Gpc50zC95sVYRKKBKTk+ly4ZFQttnwX6sHMoc5q3zCZG1cFuMhJtq2+6SC3iAtILa9Y3Xvs/T0tJHpcwOQsWPCpzp7kRjv7cUNIxZLbFvENPq6lXRAnog6WIkB6nghaQvQ75s74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410143; c=relaxed/simple;
	bh=kBRAddIXHUXh1NrMwwK+Q3Uc5sar9/R6FymD2E+StZk=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k7UoJ/VjSIC67TDDvYB3s/6BUX1/XMKFGFOfP8qrglB8WMkGb8eBgKlycWg979/Fs6jaEm9PSTwvKEET6eZ8dO7EB/+CtBjIFzimqdXF6/yzs7U3Ziwm5qqa60p1umPEObDL9HTM3zDLMZpXFd4uS/GcIQSdRoUdAhef3itKZs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6VEyJU+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6VEyJU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1411C19421
	for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 13:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773410142;
	bh=kBRAddIXHUXh1NrMwwK+Q3Uc5sar9/R6FymD2E+StZk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=U6VEyJU+UiTKzqQ2uRTXHEegY3f34jVLB2FQikTev3F0iJNDKQfXWGXTFlW7MIPsv
	 ZXIZmXxW8kiEZzKxb1L6UP1sCPTta1G2FL5dfBIzWn/NIK6KYvBsCYvZvWoLKEXyA2
	 0NfxUqwaZkV3/Rnzqg9yLP/eoU7Fy9vcrIbrTelkPJKVnaAxvKTpb+hLfM6ppG/LTj
	 C2SG06H6p/odgP/8rnxHAuvoc0G1sZB0keM6RcR3Zc5m+bJD4ujWuqP1zf04pOsLpK
	 7dlJufBmfx0xEBwxVm/uF/w4c9yk3qvxfsP7V2zm2+0qGwN09WvRZ5kCDGWA9/gcmA
	 K19ruQcSnvmVg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38a5584e31fso26575391fa.0
        for <linux-pci@vger.kernel.org>; Fri, 13 Mar 2026 06:55:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVW9tP+vo1vIRjuj5ee97GBVQ3WQ2bpG8h3fmekb4mFNSrP+Hbe48tiSO6ZSoV4RcbMEdAcK+xnhmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHmV9/5K0bLZ4lzUyUeeVbGt+/9+rlpUJIeU4qXR4+dkGXcK7K
	lQ71D4dMH3WzHHVwilZU8LMzdAARkqpOW6X1m6qmOANz8Oy7WIcEpfW70Cxv41+xFr6HdDFHhtp
	5oBuDh/+aU/woz7ZZlFAfhVTz+UBflc/cVkbPxX9jFw==
X-Received: by 2002:a05:651c:4417:10b0:38a:83f0:541b with SMTP id
 38308e7fff4ca-38a83f05651mr14520871fa.17.1773410141391; Fri, 13 Mar 2026
 06:55:41 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Mar 2026 06:55:40 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Mar 2026 06:55:39 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260313-wakeirq_support-v8-2-48a0a702518a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313-wakeirq_support-v8-0-48a0a702518a@oss.qualcomm.com> <20260313-wakeirq_support-v8-2-48a0a702518a@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 06:55:39 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md3MK_YUPxx3rh9dGOfjBBxMBT1MNVAT-XZd=kD-qQj8A@mail.gmail.com>
X-Gm-Features: AaiRm53a0ohWjYAXC_3b1_a1P_9x823vkvlD9HHudwcsHk9RyRRh0D6CSmM68NE
Message-ID: <CAMRc=Md3MK_YUPxx3rh9dGOfjBBxMBT1MNVAT-XZd=kD-qQj8A@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] gpio: Add fwnode_gpiod_get() helper
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, 
	quic_vbadigan@quicinc.com, sherry.sun@nxp.com, driver-core@lists.linux.dev, 
	devicetree@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Bartosz Golaszewski <brgl@bgdev.pl>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Mar 2026 08:08:41 +0100, Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> said:
> Add fwnode_gpiod_get() as a convenience wrapper around
> fwnode_gpiod_get_index() for the common case where only the
> first GPIO is required.
>
> This mirrors existing gpiod_get() and devm_gpiod_get() helpers
> and avoids open-coding index 0 at call sites.
>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  include/linux/gpio/consumer.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> index 0d8408582918680bfea6a04ccedfc0c75211907a..fee926c0262ce9dc4b9a3c151e74f2cf37470a49 100644
> --- a/include/linux/gpio/consumer.h
> +++ b/include/linux/gpio/consumer.h
> @@ -596,6 +596,15 @@ static inline int gpiod_disable_hw_timestamp_ns(struct gpio_desc *desc,
>  }
>  #endif /* CONFIG_GPIOLIB && CONFIG_HTE */
>
> +static inline
> +struct gpio_desc *fwnode_gpiod_get(struct fwnode_handle *fwnode,
> +				   const char *con_id,
> +				   enum gpiod_flags flags,
> +				   const char *label)
> +{
> +	return fwnode_gpiod_get_index(fwnode, con_id, 0, flags, label);
> +}
> +
>  static inline
>  struct gpio_desc *devm_fwnode_gpiod_get(struct device *dev,
>  					struct fwnode_handle *fwnode,
>
> --
> 2.34.1
>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
