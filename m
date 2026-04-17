Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596C9358391;
	Fri, 17 Apr 2026 08:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414982; cv=none; b=U2hB99zKsv3p6PTDwU52YyXsnoe4rRYCl949NT6h+Fpraxz3OMGbq5c17q1q2OsRWePU7Rmk6QnnhHwllLw5NObLAp22wXvESplyUVlPMhfsPtK5Yr3R9cI71bhKNn3Wg8U9bH5c8Y4Qiqll1qxd6q1D/On1fev1nCo8YfYppmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414982; c=relaxed/simple;
	bh=SDHu4CF6hiHHjw7wIYF2M+BZ1AnJr501zKLvFcrIIPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=gU9b8u/udUCAW/WoWULguYLDjyl5Al93NWtNHZBqbLFJNIbBr+jcvxsuXRMQUoc+AAOCT9V3zSv9FzLSrr2T+so0bX8fX2d/kDh5FmtsN35YFY6/Q78kHSQbdFev8Oe0pP5ImH1aVH1aR9F7BdJuiFRqcfCLqij/YEF3+Y9l+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=V/u9a+iS; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="V/u9a+iS"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=75813159fe=fe@dev.tdt.de>)
	id 1wDegM-00Bg5v-Qm; Fri, 17 Apr 2026 10:36:10 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1wDegM-00EXG6-Ak; Fri, 17 Apr 2026 10:36:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1776414969;
	bh=JqZmvXp+hLfJuRdo0qRIk/QxAIHQamNDzRshObedo7Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=V/u9a+iS39lP5DUq6Mwk7tWKlNQD8xUM6AeJrPQyMAA+n7VnSJN0o3wZjJmctgvLL
	 jxst+w4rgD57DJf/rGmYaBnLkZPTMkdjTNK/4yNkpQYyR2OTdQNKIc8VyiHr8X95J8
	 tC3HdzZppW1eOPEzEqH4xx4AuwXI6/tCw0rzsBboF2jkxzUW7kKJBDegCp7vfUGxb/
	 23iBOq3W+Bxj7MWqXTx43c98c1/0pI/APhzAiGbUV8ubrwUzs1VXyvSilLbbIR9uhw
	 g6L1nE7nKKcIm87CtU360Km8c0nQ9nKUUXeKovfGzOQfi91tPmi8rZyqx2mSAJBDfd
	 DNnwW/pJ7+LOA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id DE5B3240046;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id C7937240045;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id A74AE242E9;
	Fri, 17 Apr 2026 10:36:09 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Fri, 17 Apr 2026 10:35:45 +0200 (CEST)
Subject: [PATCH v5 1/7] MAINTAINERS: Remove bouncing intel-gw maintainer
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260417-pcie-intel-gw-v5-1-0a2b933fe04f@dev.tdt.de>
References: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
In-Reply-To: <20260417-pcie-intel-gw-v5-0-0a2b933fe04f@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776414969; l=809;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=SDHu4CF6hiHHjw7wIYF2M+BZ1AnJr501zKLvFcrIIPQ=;
 b=bpmSa1lj6s6S7/G2Headrpqt+f067wIU9fI/h0b9vE8+qfbEYzBfUQmOfKimgtTa/XxhnlZYL
 qX+gT65F5MLAvt6oP5ayc8iP06EZL65CG7lU5vzr0RVQF95xgP02Pwz
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-ID: 151534::1776414970-2BC2A049-D46FE017/0/0
X-purgate: clean
X-purgate-type: clean

The maintainer's email address has been bouncing for months. Mark the PCI
intel-gw driver as orphaned.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f004da89b1aa339116908f642e894..725f333f265bef416b5144c56649cb6eae736e40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20518,9 +20518,8 @@ F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
 F:	drivers/pci/controller/dwc/pcie-keembay.c
 
 PCIE DRIVER FOR INTEL LGM GW SOC
-M:	Chuanhua Lei <lchuanhua@maxlinear.com>
 L:	linux-pci@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml
 F:	drivers/pci/controller/dwc/pcie-intel-gw.c
 

-- 
2.47.3

