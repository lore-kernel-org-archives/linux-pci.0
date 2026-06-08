Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013AC3D1CCA
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928710; cv=none; b=Str7nD/sSxRGgYbGfKVOeYdyNOTVmB2Ce+7l9ULmHXbNpyTY30bzG9wVf4ZMbvohXaUQUBde1iZeN93RJZ00i/zimWpT83KzyBBidu0+8uVWZbH+usCX3BQ+tKzk5zE3vhYSpVMW8T6QxEhmO959HdqjCnK/meo2aPBZ/gPnXH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928710; c=relaxed/simple;
	bh=r39JWjk3eEXkxQF9LVlH6CaX8c7vjwP9g4eg5PVmHzo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLh7YaXJNf93B3RJICHNe6Owdjd5P57qtFIMYZeLrCBMrmIu3f4oSzJKbgBbMtGlBhlgiryagstB07zdKQfW0SL/dQy3bSG3gsy+KcZeIX736Vjv2TPppb8abA76i7iOtXN0BwjkHuI11AaCvHd0/gsCP8ef9kTmguS15sYkHmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7WJPTtF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7WJPTtF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A28AE1F0089E
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780928709;
	bh=r39JWjk3eEXkxQF9LVlH6CaX8c7vjwP9g4eg5PVmHzo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=C7WJPTtF168w0LXhxWPp6pmkxAbRRbddws71GFa8KOBA6y4dP24N6TENZ6Dy30Jqy
	 4Z1OK6zEd5Bw3yrGpNswhH+WusL6GAlPzDD1T88ODHfSLO1/jdVoc+YlGcpkkFw5II
	 fYBZCPdvPeECvoB0U87xeX1++A2oJHUSsr883bTMPsDQp1yhqOWg+Yp88UWPfku9eC
	 TXV7RICLa9cwAcu0xm2CKjfRHWTqKDNq31OYtetRUgzOHEURE0KzV7pCNKKy5lIWta
	 Q7NhbszK6JLM13KrXn4uJb5lC8XIwM1vOS7A2WXsSu5hQRe3wmwcWxSQswI5SjxIkP
	 VMOyrBMShmzoQ==
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1382c509485so621580c88.1
        for <linux-pci@vger.kernel.org>; Mon, 08 Jun 2026 07:25:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8BtIo1ACEJZ3R3+jnWFSu03CNefDvQScEsqfK8uoqyvZhbKsH2vavCje1gW55XkN7xidENpRxpmVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvJBpLXFsz3pDbpxA/trZv/isxaq4kBm+4IQKisjXSdwbybRaY
	T+3e39Mc2LYUnIIp0t4zbEdpstB0DDcxqInNerSXp4nhWmoz32JzyUYmy6vHQUKKI5PP6FuSTXu
	aBi3vu7gvLzR5NAn0TUdc7tz2FpJVoJv9ENFXZuLbWQ==
X-Received: by 2002:a05:7022:62a3:b0:135:d749:574f with SMTP id
 a92af1059eb24-138066d530cmr7679756c88.13.1780928709070; Mon, 08 Jun 2026
 07:25:09 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 07:25:06 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 07:25:05 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260608091702.3797437-3-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com> <20260608091702.3797437-3-wei.deng@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 07:25:05 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdiih9kFj9mWe_9cqd5T4B4Q0ekd-5YhJ6X+dgiqwLtLQ@mail.gmail.com>
X-Gm-Features: AVVi8CeA1Wijm5yAWA_-v3VlKzCbZNsMunOIP4iwNyh2boGjmtB7gJWUNbsUdIY
Message-ID: <CAMRc=Mdiih9kFj9mWe_9cqd5T4B4Q0ekd-5YhJ6X+dgiqwLtLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: lemans-evk: Describe the PCIe M.2
 Key E connector
To: Wei Deng <wei.deng@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pm@vger.kernel.org, quic_chezhou@quicinc.com, 
	cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jun 2026 11:17:02 +0200, Wei Deng <wei.deng@oss.qualcomm.com> said:
> The lemans EVK has the PCIe M.2 Mechanical Key E connector to connect
> wireless connectivity cards over PCIe and UART interfaces. Hence,
> describe the connector node and link it with the PCIe 0 Root Port and
> UART17 nodes through graph port/endpoint.
>
> Also add 'compatible = "pciclass,0604"' to the pcieport0 node in
> lemans.dtsi to allow the PCI subsystem to associate the DT node with
> the PCI-to-PCI bridge device.
>
> The M.2 Key E connector is powered by a 3.3V fixed regulator
> (vreg_wcn_3p3) which is sourced from the board's 12V DC input rail
> (vreg_dcin_12v). Both regulators are always-on and are required by the
> pcie-m2-e-connector binding.
>
> Also add the serial1 = &uart17 alias, which is required for the
> Bluetooth serdev device to be enumerated on the UART17 interface.
>
> Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
