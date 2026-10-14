Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E685851CF4E;
	Wed, 14 Oct 2026 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791984863; cv=none; b=WOLlAg5/Ib9EPLZl7OXyHOWWdF11Q9x/S39osjsjD5L0ljUm9P0z8nQFfJPK+D6dJWoK5WSoawvMDc7aurlp83MQm8E6ohk5IPrK6IC0teLCdrbeSrtuC5ujylFIMfIc0Jzx88ZitZh6oHd1b4W3QpFBncFKcUTLA1JNGcRrm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791984863; c=relaxed/simple;
	bh=oQT/vFq4L2+1ykzH4bcsj6Dl0qjssokYfXpiBYK9RgQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=kXwbfG/2q6mI7y5X1L8I4T/Fw3/hfDQbwbrNERpGyZFMf2/pNPbnYZJiJHdGPKukE51nyf8+qCqvES9XQNSgMX7ebdHEF8UltoAyz7I1MRC4E/vVERGz49krDQ4sXhCc3mUR3WZ4ooZuoB5BTG54lzBLpKzKWqit0T0Vy13Ac3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38741F000FF;
	Wed, 14 Oct 2026 13:34:09 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 0/2] PCI: iproc-bcma: Use EROM instead of devicetree
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Semih Baskan <strst.gs@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Arnd Bergmann <arnd@arndb.de>, Rosen Penev <rosenp@gmail.com>, 
 Rani Hod <rani.hod@gmail.com>, bcm-kernel-feedback-list@broadcom.com, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20261013220421.1588051-1-bhelgaas@google.com>
References: <20261013220421.1588051-1-bhelgaas@google.com>
Date: Wed, 14 Oct 2026 19:04:01 +0530
Message-Id: <179198484126.63727.459652495621312738.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=962;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=oQT/vFq4L2+1ykzH4bcsj6Dl0qjssokYfXpiBYK9RgQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz4TMGL/YtFvclINMLC37pDBET+uU5MewK8ZwK
 mLcXFFcMzyJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas+EzAAKCRBVnxHm/pHO
 9TFJCACEdnC2gLjnShD19IBYYT/ZlRWSBBIhCLaM36uZM/D9ApdLK3k+oGIg+xcBjIAp7RR5DO+
 9+gSYdovqZ1bGIxwNVoZ9NedvDKPNp6am9yjm2xMC1pz93S9Yvr8HYjoj+jyEXLlnLwEYChm8vZ
 CTC+dm++dijdj7VQvPuc59vCNvhuIo2FwykeHMH3T2fN7T1Tc+xX30QhqVI5mf7VtcRQjLJ9G6Q
 zpBA39E2NGkeGNrzDx2YYkonv21lA4xVXXwAVbL7wX35mIPYl9rWpDoZHFEADh4gSH75D9UAJyZ
 29ysRxwEFWC+zTGbxEQkTDhlAYagIqt61/1cX4MEca85rKTM
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-13 17:04 -0500, Bjorn Helgaas wrote:
> This is a combination of these two patches:
> 
>   [PATCH v3] PCI: iproc: Use the EROM outbound window on BCMA
>   https://lore.kernel.org/all/20260807160526.379-1-strst.gs@gmail.com
> 
>   [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
>   https://lore.kernel.org/all/20260912043626.437-1-strst.gs@gmail.com
> 
> I think it's a little simpler because it keeps the use of devm and it
> doesn't require two pcie-iproc-bcma.c patches.  I didn't sign off on the
> pcie-iproc-bcma.c patch because it's Semih's work except for the minor devm
> adaptation.  And the commit log probably needs some work, but I don't know
> enough to describe the platform/bcma driver issues.
> 

Applied this series to controller/iproc-bcma. Note that I changed the authorship
of patch 2/2 to Semih and collected his tags. But I didn't add your s-o-b. Feel
free to do it yourself, if you seem fit.

- Mani

