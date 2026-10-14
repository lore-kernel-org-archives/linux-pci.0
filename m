Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B35304C5;
	Wed, 14 Oct 2026 13:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984991; cv=none; b=Ikrxbm2KkqyRy5bI+/rfK7gG6U4alzObowqEv1YVXxKYIKHVtauGsaNCeITcScRe30n8l+zD8JrzYuFVuUxzOH/P5Inw1cuAxLTbTCSuPUuod7SsIZxzyV11MBK8UTg5dFGO6nE8jzC1tgoiDK0JljV+kxwCkNgcYOj+xr6q9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984991; c=relaxed/simple;
	bh=q6gyLLpwOpTv4wD53GWhRELlUKutlNHW545+PEMzwSA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dncb29RME5uwRgb/5Yqgt9kvSr2+SZDeK6Q8K6iWdwYWHlg8frxn842klLFE384bsLI92Isxtl44LOpQbAXua23eYZTYuSRCkhERzUifdQ/cZhoeSoHovM/YeysyqSVIhKyS0q+S1Empa2nkCWxxgQQgWiPhpllQhz1dDz6Us0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOPD676B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOPD676B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD2C1F000FF;
	Wed, 14 Oct 2026 13:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791984987;
	bh=/Kg+A+xrZdns/Gt1pdYxZtMAWhuUXTyI/p/XIqtBsPU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IOPD676Bzqg8w3PuxzHaWtPLz4Fr1BGavAD4ZKepp+VzH02KwLCArkK2JUaJy5VYC
	 GmztHM30ObE8AOA7cr61nyWpFnePu7d8J3Pks9mbG8Tb1fkZ1FOCX+1hT+zV6IL3Wq
	 RYZcSCn7zwieXuGT55CchkP8tFFxchV6wQFcHoYf8P+NMSthRHY7V9RwETLF+mwieI
	 rqQdjhZfKPPDDnVAuRg5fS/cL+dRV/1SKhDEWvSmaRhjaT/wk1X+d0Ly1vCoG7Lu/1
	 lkS4LaGJfzGirFDwp5wMFysaLGVKAcJy5ssoszF04c6Bcp8X/x/iDClgu6PPu0XgAf
	 qEeSpJj+3eNbw==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Ioana Ciornei <ioana.ciornei@nxp.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Vincent Jardin <vjardin@free.fr>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
References: <20260928-for-upstream-pci-layerscape-async-probe-v1-1-76412d887baa@free.fr>
Subject: Re: [PATCH] PCI: layerscape: async probe by default
Message-Id: <179198497640.63727.7466078377590135207.b4-ty@b4>
Date: Wed, 14 Oct 2026 19:06:16 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=303;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=bIScKkSRWfgKMp5sG5Isx9f9wVbp2+a5UTcxtA0Zz2o=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz4VV1pY342QQGnH8cFuzx4aa0fkm4cHc0AiK7
 +xJU8Y3iL6JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas+FVQAKCRBVnxHm/pHO
 9XC+B/0ZHyHZhsScilHuWvjjib7MCUyNylWS37lr4ITYD4lMWo+3rdnEyjgV9vXzxi0hpamuRKq
 dquWb/DbCBlgT5aenUd7qndALvWtkTK//owK7DqOL/W4q4ElEKL7xqps5nrJghYX/vZtEId+dEl
 bRjtbwKSiuUZCh19G4f4P4rvwV1UmoBN7wYsWGkH52WEURKKAbPRTjl+Zpc2G8Dn+SLzceMOSK2
 CTlvecW3mPlO5rSLrxADHJuRiDsZatXJYqtv6wzfmS4Nzb0Q8b3l2bM77KOcBInbRzhTeiEHJo5
 WucunzBLhRoRKzKTunS3JDCh5K4sVhQ1WmsLA6CdqSodHGKU
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Mon, 28 Sep 2026 15:48:09 +0200, Vincent Jardin wrote:
> PCI: layerscape: async probe by default

Applied, thanks!

[1/1] PCI: layerscape: async probe by default
      commit: fd592bcb77f834564e787b8c809fa01f1af81731

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


