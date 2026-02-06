Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C7728134F
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390784; cv=none; b=t4SXPSU6CNWuhAg1zzQrEjvtnGwMh4z6wV0sV5W2yXlTnvL+QhicYpl09sGXyNGe4meHCD6IwCVOClmeUVMKqCwM0FTpURq/5JhAabbmRpf4ewDOF5wP6g2jK5zQde2GfaKaswaNlHGNSxH9BUrMT9wmZHO6N4VPf7WLrdiGe9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390784; c=relaxed/simple;
	bh=xjOVDKT/gqOUJFAfsyaZBX7X9mW0mQLPkR+mW2ZCvqI=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=flfuBpZO6T8v2le7sHkFjA/Tyitua9BcHqWoA8ZkbuWKuazNv6nN/kOJcSnahJZnO8ZhL83L342nKQdfJDqUQ/0CYBbtrAXohdToNMfKtWxFiL18iP+f55VzhgKOblYA3OTeWTCZgaous8CkpbiSR0GqJp23RIF/9vAx/YiMSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3vUzNgI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3vUzNgI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAD4FC2BC86
	for <linux-pci@vger.kernel.org>; Fri,  6 Feb 2026 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770390783;
	bh=xjOVDKT/gqOUJFAfsyaZBX7X9mW0mQLPkR+mW2ZCvqI=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=b3vUzNgIAtOaZZf05U3bggBD32H6RnAUcP6ZjyLLeqZB9x7ltvEZJvDWvBxDYqcgx
	 p/4DoZ/enUHDfrD5U96usZ2AHUWk9QGorP+XaROP9J6qVqK9vcuaXDydqfXgbbiMNx
	 nJ1uocRdlngudeiHcAS9zR0eCQbNDW51/E9yqJpoF5B9NQZau0LecdPA4fE8UU9bk5
	 upuauK/WXN14JD4KHbfEedOtRAa4JLV++JIy3QPNBeKnNAnJhoqLPx7ssb0TCYjYAQ
	 DFlFMYJqDbFd4TEnTwJpogeUyGcRyCRuYn/CP3YMkxf6MwUJBATRt5JTM2GLAl5jbN
	 QPqoBfLiPZBxA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-386b553c70eso8205581fa.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Feb 2026 07:13:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUGGGnshUK17vfdDvsv4ejWTSTEUivH24A6FU/fzjMlDJxJOkPV75S5ylTgAv4YOLCQsgZd7KSb0LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOhuLAsN+lvn6aoU46X2ijG+GdL4YbOd5Y7mhnTTT0IPA2LRQb
	O3zBHX8ul6R9wftbi8WsZQaoZ0x4+MgEnjEYuQtlyq1yMTVbg1j2TtqX/sWj5FgW/kAVibCFp+/
	/4JpkfLeANHw3rV0z/nPAuglb3JzIcH7bQvfY8q2trQ==
X-Received: by 2002:a2e:be0d:0:b0:383:1c5f:84c7 with SMTP id
 38308e7fff4ca-386b68180fbmr9558811fa.12.1770390782264; Fri, 06 Feb 2026
 07:13:02 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Feb 2026 07:13:00 -0800
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 6 Feb 2026 07:13:00 -0800
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-2-5b79c5d61a03@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-0-5b79c5d61a03@linaro.org>
 <20260206-topic-sm8650-ayaneo-pocket-s2-base-v3-2-5b79c5d61a03@linaro.org>
Date: Fri, 6 Feb 2026 07:13:00 -0800
X-Gmail-Original-Message-ID: <CAMRc=MdkPZQOze=A_orwCLRpu5s=GA=HOvSjpU72o-p3BhREdQ@mail.gmail.com>
X-Gm-Features: AZwV_QjSWizfT3josb5AhWS6l_uEgzoWQTjoTt1Hi3foFihUPkEQ01zIgsoa2yQ
Message-ID: <CAMRc=MdkPZQOze=A_orwCLRpu5s=GA=HOvSjpU72o-p3BhREdQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] pci: pwrctrl: slot: fix dev_err_probe() usage
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 15:50:30 +0100, Neil Armstrong
<neil.armstrong@linaro.org> said:
> The code was not returning dev_err_probe() but dev_err_probe()
> returns the error code, so simplify the code.
>
> Suggested-by: Bartosz Golaszewski <brgl@kernel.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
