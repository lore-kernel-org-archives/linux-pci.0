Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4E3CF051;
	Wed,  1 Apr 2026 09:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775035917; cv=none; b=OM/9KZpHFjkBqHWUE/qyxOMU4ZmnJ1k90+mOL+/KGUebL6KEyjtTazBvQbcvHCoS1sSmEeW+qLu020k+a3mhbCJqnusKi//n1JF5heDYCjgP05yS2RVC2Lw0xGYLRifp9ifSeeBfaMs0iB4ReElxsQdZqt85UKvNng/jLH6AiM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775035917; c=relaxed/simple;
	bh=TNKQcUOxp3IEx4/KXd1OG59UNOtH64WRIf6g/vY5agA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:Cc; b=cBn89uN6DocMG+diaH9Ux12ib2rCVJoMef/iObFJbXeB+ZrfQGHaGVTFIS4ZjyL466F4hmGswJDCfDxKeUM+CVmJ3qTuhRvJUd9SZmKa7hoyG1JP/v68dijiNtYXecIoCC0F8KNUjHaY/uJ0yM/mGz0ucsF1nTFN7QS08KVcY+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=qQA2uXvN; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="qQA2uXvN"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=65659f006e=fe@dev.tdt.de>)
	id 1w7rvM-001Sya-B7; Wed, 01 Apr 2026 11:31:44 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <fe@dev.tdt.de>)
	id 1w7rvL-005aF8-PG; Wed, 01 Apr 2026 11:31:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1775035903;
	bh=E2ZTfUj86mp0drWTHwRl8zkHJBvXCjXQAwVjq3aAu94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qQA2uXvNovtshODBkmvHejw6K4NByuX/Q+J5ZJw4XrY1c4GLjcIFeCqmL/qB3f0WU
	 Ai57eZFlJeqdjc6fK7147xyW1v/kIT9v3N9fp7GkK/JFu83QtZ77/yjI7FKiFbzVYe
	 Eaed17IDZKufJxLABj/+BNMVKqdBnIt5aycuegC3RrG+KuWal353xbvfMG6eZiYQxu
	 JPBVjvntst1nzk39ApWoCM/okLuvP0UTgyU0DaNaRpv/ga2K3kNxLLCVNrvu9c/Iau
	 31j27QFVsURANzrAkl4l6MrbZeookchz6epEbxIpyQd8MVcW8zILmtmtq5u3KAi3nf
	 huqI8c0W4zk1g==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 4FBE0240042;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4311D240036;
	Wed,  1 Apr 2026 11:31:43 +0200 (CEST)
Received: from [10.2.3.40] (unknown [10.2.3.40])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id AF3A623C7E;
	Wed,  1 Apr 2026 11:31:42 +0200 (CEST)
From: Florian Eckert <fe@dev.tdt.de>
Date: Wed, 01 Apr 2026 11:31:37 +0200
Subject: [PATCH v3 1/7] MAINTAINERS: Remove bouncing intel-gw maintainer
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260401-pcie-intel-gw-v3-1-63b008c5b7b2@dev.tdt.de>
References: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
In-Reply-To: <20260401-pcie-intel-gw-v3-0-63b008c5b7b2@dev.tdt.de>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Sajid Dalvi <sdalvi@google.com>,
	Ajay Agarwal <ajayagarwal@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rahul Tanwar <rtanwar@maxlinear.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>,
	Eckert.Florian@googlemail.com, ms@dev.tdt.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775035902; l=809;
 i=fe@dev.tdt.de; s=20260205; h=from:subject:message-id;
 bh=TNKQcUOxp3IEx4/KXd1OG59UNOtH64WRIf6g/vY5agA=;
 b=IMH0r/M4bsdWwt18oZCR5ztzVwjNcLpySPx/xMZk+tPmSJOeeHtuYuxrv9kyuo0fN02eIO+hM
 +BpnFuKjz6WCcKgsqAUbhPGkPXz5+kP/ak7jTWFhbVuOgpZz56QBjPQ
X-Developer-Key: i=fe@dev.tdt.de; a=ed25519;
 pk=q7Pvv3Au2sAVRhBz5UF7ZqUPNxUwXQ78Jdqu8E6Negk=
X-purgate-ID: 151534::1775035904-4A7C8233-03B41B9E/0/0
X-purgate: clean
X-purgate-type: clean

The maintainer's email address has been bouncing for months. Mark the PCI
intel-gw driver as orphaned.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 96ea84948d76aff5e07579911d0f370ae13f481b..26f3b2e192fa9ef2e1c89d2310bebaa0a67dff00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20505,9 +20505,8 @@ F:	Documentation/devicetree/bindings/pci/intel,keembay-pcie*
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

