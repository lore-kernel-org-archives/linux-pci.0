Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8870B30E0F2;
	Wed, 15 Jul 2026 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123830; cv=none; b=UrhaDImyLw3dklc0N60tpNj5uiqL93MNthPgQxzeo0R8vh3m8Edw/g51OeWOpc/W4QYVhKnsdss3QnyMTSF9kG/VXabVGM4QVnuRlKqgQWGcuaQRO5HtsjqtI1EdfeRtIk9iXySeqrdib7+vIP3kxxBXJmtoHTxdbXMPpdJ+Xr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123830; c=relaxed/simple;
	bh=dHP/7DYd+8lXgYtJRsqTkS/pDyNsTDNvgDbPkxZ/wrw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=flWCuFW9HGgCnEmXXaZ1aXSt3a0UuvLCXdVWqD8kSBmoLsjLhXSdw3ntuJsXYgDMXYnevFOVOCKQvtS7O+vYSmw77f5unYYyJFy4lgoU7qxUboxro/8jGMt2e9FcS/rp/w9JCQFr11xN33N4L7pFhHck9FGce3xNLo1lihAjdX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQOPV/w6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQOPV/w6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E02F1F000E9;
	Wed, 15 Jul 2026 13:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123829;
	bh=6L+vazQzDXMLa/yjhu8CrwcvdpiJna1r16t0Ef63MtI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XQOPV/w6jbclzedaGV+pbm6Ps+bkLkulvSxSGscKzEqZ1QkFhr72D9+LeLREzTTNU
	 wjmUafwLEuBcmg93wmSzFO8mIA2WiLFhinoVsXqC70reA+Pqg7Fxw4NR5w8Lb4hCvj
	 CuOZurkZ79dBArFKFGTbhBGMv/XPrP+2ijd1piV1oJE9OOoZ0VpnSdMTh0YdjiU0Gp
	 X81BPceIxIWeB8YSSmA8GJrIfEkPX58LkOXzYC86JjSYuCGuR9H+BIT3ji1IX8PkYM
	 NuNfzot3s9JAe2rAnFEgVFWZ7aJWemewCfm72/5CfJpT0CNKVlaAkYk5jLFZWczLDJ
	 skNbekyTLQtrQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Yixun Lan <dlan@kernel.org>, Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260704122538.92830-1-pengpeng@iscas.ac.cn>
References: <20260704122538.92830-1-pengpeng@iscas.ac.cn>
Subject: Re: [PATCH] PCI: dwc: spacemit: add missing MODULE_DEVICE_TABLE()
Message-Id: <178412382616.147568.15614000262290190322.b4-ty@b4>
Date: Wed, 15 Jul 2026 15:57:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Sat, 04 Jul 2026 20:25:38 +0800, Pengpeng Hou wrote:
> The driver has an OF match table wired to .of_match_table, but does
> not export the table with MODULE_DEVICE_TABLE().
> 
> Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
> information is generated for OF based module autoloading.
> 
> This is a source-level fix.  It does not claim dynamic hardware
> reproduction; the evidence is the driver-owned match table, its use by
> the platform driver, and the missing module alias publication.
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: spacemit: add missing MODULE_DEVICE_TABLE()
      commit: 46a1b74f2cafaa0152a4c994c60034f14119570b

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


