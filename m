Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889442;
	b=fTAR4WQ+tBTOIvdl5KZ3nsGzW0JVpMhmZMEzT3XmnT4rmZKbhnLkJUkFkF5FNFAazGCJ
	 iY7Lw0wqfKRrS2WiaaWZ5ZJG9haD65kNLPPVFDW8toXeriWbkOuQkONL66rTPxjybqJxh
	 OVWpfc8v8fXUstn+oeIJOl8jodv10t7zGhKVEkqBzXoRXUvQZ2nWOczA7qXHa/w+Axs5w
	 dJjGTg/e/kemzOdHTKDnQmx5isiXfWmGUn2shkElO1/S//uNu6elfm1/qHofM2qqicwTI
	 EkXOiccZED+7nbTk3HI9bk9MIsuwJWkDi1agd5uIDcpZZm1J6J5yzbmNtkGwEzIGclQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889442;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Qt8jTRfSYXFNQvXMCOR61j9jMXZvCe93vdAW5CLogPI=;
	b=vnMJg8/6YDJbdDMP8RqM4KYDbrb9GL+MKFxe1CAx6ArAn7M4ANS4XmIstt8HyEYgZXm0
	 qb4VDdtZ7YiXyUd2uvP1M9Ek0+JL5Mf1qWX4ftmxgSAKKAOqnpODhYAdzxJrUza4p1No1
	 U8A9oftduavRlS7+GY6qEBs30brVtnXOvlnoQ5PASSGAGjvEFbnMGjerlWt/WxXHJAz9f
	 K4iv7gsktFg4GSKLE0l3pQ+tCYioQjZdY3X4JteCyS5OMVIjcUSni5bSdCbv8mnnX5a9d
	 BFK65UEFDYOIi4VBsZN3Q5oR8Hx2oCd6pidtr/vI9IdXmhdKKB4KosmmkAAW331LXFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E/bKvu1I";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0038606A31B;
	Thu,  5 Nov 2026 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E/bKvu1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924D81F000C1;
	Thu,  5 Nov 2026 14:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889441;
	bh=Qt8jTRfSYXFNQvXMCOR61j9jMXZvCe93vdAW5CLogPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E/bKvu1IDqKDccxmJmRM8Pie+5UcXNnQTcDm3ocVTNyh6DWweDUwyF6WSUF1EDTke
	 CsN4E8IXRMFCB7lQGcvVi9yOpxx+KV2Jo2jhT02nZ5NZKFrmn1uS/xMAvC87UIq9lM
	 Xu3xO9vGQjfYBOM9G/9N3isAtGaZ4rD8xkpBZ0gzLZTc6J3rJhDrpwZRkJca6TLRBr
	 TBqBgXBqkPdvgvNxPiVQH3JboHc7NEOFMJJlvFxkhiGdoLKf3Fe9JiG8XQMW6OU7xt
	 ZILcICm6dA+v6FBYVld9tJjz5KPTdJWu3Mx3FhDuaHoAGh8BT9jl4DnYW99Bl9U05O
	 Oz1uTzdS6lXLg==
Date: Thu, 5 Nov 2026 20:07:18 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	krishna.chundru@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com, 
	deepti.jaggi@oss.qualcomm.com, yadu.mg@oss.qualcomm.com, shengchao.guo@oss.qualcomm.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Power on pwrctrl devices for firmware-managed
 hosts
Message-ID: <auyUXp1Fgk2yC7fZ@debian>
References: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>

On Thu, Nov 05, 2026 at 06:15:21PM +0800, Zhangfei Gao wrote:
> commit b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power
> on/off, destroy APIs") switched PCI pwrctrl users to explicit create and
> power control APIs, but only added the calls to the regular DesignWare
> host initialization path.
> 
> Firmware-managed hosts bypass that path and probe the ECAM host bridge
> directly. Endpoints already powered by firmware, such as NVMe devices,
> remain discoverable. Endpoints that rely on Linux pwrctrl and pwrseq,
> such as WCN7850, remain powered off and cannot be discovered.
> 

NACK. For FW initialized platforms, FW should power on the Endpoints before
booting Linux.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
