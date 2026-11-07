Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794069645;
	b=UVl616pYKl0ajqRtF43TgtuI81tMgZSw5gRbYQE+5Uk/xk1ORaYMxaMN7i9rS+tRsmgC
	 S/5OsRv8TOizxp5/NsVUr7h1bLC9BjtYEwP8EpzzfL0VrYKPNJPQBwepk849sjCnEVjYP
	 upgEFLpn4JGEbDDY8Ggz04imNJ4bOoJIHqsCepbFnvRWKSXnHjeagDvS3XS16EE3GhHhl
	 7bNS99u2d7vcReB/qcZj7K9DVUGTYXMImOmicByQL647KYWw7UGtsZauys8QYPRyor+Vi
	 Su7XdAcA7dUtOAcSEVAysy7671rOI2ob+jCM+scqV6SOLBLkMbFgjMxxEn+oKjozbxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794069645;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=oyZGN7VE4rzGGu6dwgYopEdGRTAy6qdzVMyyhZtR/qE=;
	b=i0hxaMqlCvX1i5LiAaMfgKB/pbx/Yc8XHjlMplrJFDPKx8uZyLUV1v5DupxeFyqellbQ
	 OsEAqUqnO1usj/U/Kg01aj2rG6qVeJCf87zPnK5vEQkxxIsfi+63KYLNl8wF11tUxJXRH
	 06jZBlIOKNbr6eShDoq2CRt6AGWQpGWB4tMFAbXE/TADCCy80bxUnHUyOIRTvDK+KP0jA
	 pvEJn2qc+6jP71W24Le4caB60RWhJEeLYa8D1Lml4yI32t6aAwuV7yhK9pDCPoR9ecor/
	 +3R2An3LrZwjBRcZzDSmsnXnAtqGeKER+a1EFEoLvVHPdhYHPmqRXaG/D8ZlVKi+VGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC246606A32C;
	Sat,  7 Nov 2026 16:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DC8A1F0089F;
	Sat,  7 Nov 2026 16:40:43 +0000 (UTC)
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] PCI: qcom: Power on pwrctrl devices for
 firmware-managed hosts
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, linux-pci@vger.kernel.org, 
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
 bhelgaas@google.com, krishna.chundru@oss.qualcomm.com, 
 bartosz.golaszewski@oss.qualcomm.com, deepti.jaggi@oss.qualcomm.com, 
 yadu.mg@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAFkd8hu2aLp_MGbT3Lt0wv96sUQ705fBsaa_sn3P1_XUuruKYw@mail.gmail.com>
References: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>
 <auyUXp1Fgk2yC7fZ@debian>
 <CAFkd8hu2aLp_MGbT3Lt0wv96sUQ705fBsaa_sn3P1_XUuruKYw@mail.gmail.com>
Date: Sat, 07 Nov 2026 22:10:42 +0530
Message-Id: <179406964231.65886.10596417299119607614.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1969;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=jaCY8HUzhyhSMMPiHqi4Fxf0VtDkX8gvIrfoWBqCNzU=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq71SLApPfRmhrU5GP/ZAEfiQYaGa3Fzl55nRVL
 /lyomfA7S+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCau9UiwAKCRBVnxHm/pHO
 9Y/3CACKuMlSiJqG9S2SlOe7uSTm946oOt3cgsfeSZ3336Noajm0mDXI/InAHb342H+/7bEAKoz
 cDudP+i6xayXz8KY8aQTT4p9DAT0Ov8L2WN4TV2C1cOzQnLbhisevPFy83LPwm+aITQEpfl4fbw
 GvfytiQEsObXcvY/LUcAYb/UpU2rWZDgTu0m4TYb4wAE9Pjb5cUsS5/Slx7CtB3LSLww6TU4fWa
 9wMiiskUJxLqso10g7/8Pjg9zZHdRQpbJr5vHsNPtm2avhuAQtoyCEbV/kOQDws8AJf+FaycK2R
 tTvDAKsyUVenFPh8WuYAZaJXsodvsgdGsLHu99FKBrR3sa4O
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-06 10:24 +0800, Zhangfei Gao wrote:
> On Thu, Nov 5, 2026 at 10:37 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Thu, Nov 05, 2026 at 06:15:21PM +0800, Zhangfei Gao wrote:
> > > commit b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power
> > > on/off, destroy APIs") switched PCI pwrctrl users to explicit create and
> > > power control APIs, but only added the calls to the regular DesignWare
> > > host initialization path.
> > >
> > > Firmware-managed hosts bypass that path and probe the ECAM host bridge
> > > directly. Endpoints already powered by firmware, such as NVMe devices,
> > > remain discoverable. Endpoints that rely on Linux pwrctrl and pwrseq,
> > > such as WCN7850, remain powered off and cannot be discovered.
> > >
> >
> > NACK. For FW initialized platforms, FW should power on the Endpoints before
> > booting Linux.
> 
> Thanks Mani for the clarification.
> 
>   To confirm, for a firmware-initialized PCIe host, is the platform
>   firmware expected to perform the complete board-level Endpoint power
>   sequence as well, rather than only initializing the PCIe controller?
> 

Yes. By the time the Root Complex power domain gets turned on (which happens
before the controller driver probe), both the controller and Endpoint should be
ready.

>   On this platform, WCN7850 requires PMAU0102-E GPIOs 6/7/8 to enable its
>   power rails and GPIO10 for WLAN_EN. Should firmware assert these GPIOs
>   before Linux probes the ECAM host bridge and keep the Endpoint powered,
>   including across suspend/resume as appropriate?
> 
>   If so, we will drop this driver change and coordinate the required
>   platform firmware update.
> 

Yes. All the initialization required to power on the Endpoint should be done
by the firmware when the SCMI power domain for RC gets enabled. And when the
controller driver probes and scans the bus, the device should be visibile.

- Mani

