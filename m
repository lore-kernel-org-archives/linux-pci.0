Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447368;
	b=Q295c5Rxave1UpdANCEqOCZACz6Q4QY3LkHl8YjKkIScHoHPYLNTiMur8tmBh5WC6Y8L
	 5/qheO2WamvFrMJk56eIjn1BZEc1AUmuM/Ej9yMWDCcL3OytgrPclXZOr7krALdjZG1QP
	 OApeyPnCUmCJADDnTk4eDgmSClL1dtUD/ii0SoOPM6hxRJ7znQ685Jt5y3p1CHwawys5j
	 XDXMBUAJ4Oiw6juB1aAtcL/9ExVz1fMnWgyWBUW7Q+JDUpNudr003rljcg+HPqY6avQ64
	 FleDqPHXIeTlAIudsi41sLHAQKtj2EoQmq1bIgi1RbXTike4WkM016tQdU2PwEHZtXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447368;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:Content-Type:
	 MIME-Version:Content-Transfer-Encoding;
	bh=N7w3mU3Z/aQ234J6T+KznqfhqxGooAWYmjTC1watK8g=;
	b=lRqQVz5OpmEM8M7XAcqLeT8YO+IdDGs3a9c2tBxtmMWRMBnrMwe+He2XHrAiQ9ZNnvqJ
	 2IHSO5O07DQo8rn5iN6jAtuB9GCIsglg3EtBW8UwVQt49EGhsrxykhCO3F1nLxcDvbd+S
	 sRQuQq5OyHo76FZpQ4j21vKuHaPCCrzAFbqR5pnyD4rH0APWJY1+vpxxFebBinj6Z/MbX
	 mGcfZiIDm2a8FORtQB5fiBPkd1CQzvGWoLblqnyUmiA61ZN71Ll222gfYg77CIVmnxf8x
	 mRQqjFr2x18+cpsCMHxhDx9x3ft7rYU4pceMBYVuGx2pSOWagGsiWbn/8LseyUKXScg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57D0606A334;
	Thu, 12 Nov 2026 01:36:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B57D0606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6b8b89e2de3911f19a56ed5b684f684d-20261112
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b233f480-255c-4cfc-9f14-6b08b8beca87,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:d3e16174d883be0d854b7b11a293285b,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50|99,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6b8b89e2de3911f19a56ed5b684f684d-20261112
X-User: yuyang@kylinos.cn
Received: from kylinos.cn [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yuyang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 306454315; Thu, 12 Nov 2026 09:36:02 +0800
From: Yu Yang <yuyang@kylinos.cn>
To: Thomas Gleixner <tglx@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Shannon Nelson <sln@onemain.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/MSI: Skip address mask check for MSI-X entries
Date: Thu, 12 Nov 2026 09:35:49 +0800
Message-Id: <20261112013549.1130072-1-yuyang@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <87mrriun77.ffs@fw13>
References: <20261109-pci-fix-msix-alloc-failure-v1-1-6370c0b84354@kylinos.cn>  <87mrriun77.ffs@fw13>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Thomas,=0D
=0D
Thanks for the review and the suggested approach.=0D
=0D
> The core cannot rely on random implementation details of drivers and=0D
> architecture code. It fails gracefully when the provided address limit=0D
> is violated to prevent hard to diagnose subsequent failures.=0D
=0D
I agree, and I am not proposing to rely on those details. My concern with=0D
the pci_msi_broken approach is that it disables MSI unconditionally,=0D
including on platforms where the MSI allocator returns a 32-bit address=0D
and MSI works fine. ahci_init_irq() uses MSI as the first choice for=0D
single-port controllers and as a fallback for multi-port controllers, so=0D
this would cause a functional regression on such systems (falling back to=0D
MSI-X or INTx instead of MSI).=0D
=0D
> Coming back to your AHCI controller. That's broken to begin with. Assume=
=0D
> that MSI-X is not supported then MSI setup would fail the same way. You=0D
> don't notice because MSI-X is always enabled on x86 platforms.=0D
=0D
Understood. The device's MSI capability is 32-bit while its MSI-X=0D
capability uses 64-bit addresses.=0D
=0D
Would a device-specific flag meaning "MSI-X supports 64-bit addresses=0D
even though the MSI capability is 32-bit" be acceptable? That would keep=0D
MSI enabled with the existing 32-bit msi_addr_mask, use a 64-bit mask for=0D
MSI-X, and keep the verification in place instead of skipping it. The=0D
quirk would only affect this ZX-200 AHCI device.=0D
=0D
Please let me know which direction you and Bjorn prefer. I will also fix=0D
the Fixes: tag as pointed out by the Sashiko review.=0D
=0D
Thanks,=0D
Yu=0D
