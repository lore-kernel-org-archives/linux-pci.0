Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LkBoNsPO"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650710F3;
	Thu, 30 Nov 2023 08:57:12 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPA id 92DB61BF212;
	Thu, 30 Nov 2023 16:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701363430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=03BrarHheQTm2ykoOQK9Gavt52h0IRg+LP2b9wAKWEI=;
	b=LkBoNsPO/NLskV7htM0BtXTYvsIr1YwKc7YidAZmSHGGnE+7fWKR94HrejLqgdm7qWiSML
	16FNvIu8vRzphRZF8c7E99Vk1wl+BHoGwUAU01gRqVbAm8V7G924FRXwRR9+i79oImKiCP
	Gf7Ff/DRQpOHTLJ2Pm9iE/wy8NPKI772SQTR34CDeBn/fjqlJ4kc48VNNLvPV9S5jTxfP/
	7Szd9nqw7vPINBajJpFXn5hC7XaxmxS5J7wue6serYuyIx73iT2bp90I7OrQ1qvkrhPQQ1
	MNO4/PpE+q5Od4T2oXNYOGVZcsUAWPhmYSkBVO4pguxV6LX6Yi+U0gf3CI/nKQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Rob Herring <robh@kernel.org>
Cc: Max Zhen <max.zhen@amd.com>,
	Sonal Santan <sonal.santan@amd.com>,
	Stefano Stabellini <stefano.stabellini@xilinx.com>,
	Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v2 0/2] Attach DT nodes to existing PCI devices
Date: Thu, 30 Nov 2023 17:56:57 +0100
Message-ID: <20231130165700.685764-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

The commit 407d1a51921e ("PCI: Create device tree node for bridge")
creates of_node for PCI devices.
During the insertion handling of these new DT nodes done by of_platform,
new devices (struct device) are created.
For each PCI devices a struct device is already present (created and
handled by the PCI core).
Creating a new device from a DT node leads to some kind of wrong struct
device duplication to represent the exact same PCI device.

This patch series first introduces device_{add,remove}_of_node() in
order to add or remove a newly created of_node to an already existing
device.
Then it fixes the DT node creation for PCI devices to add or remove the
created node to the existing PCI device without any new device creation.

Best regards,
Hervé

Changes v1 -> v2
  - Patch 1
    Add 'Cc: stable@vger.kernel.org'

Herve Codina (2):
  driver core: Introduce device_{add,remove}_of_node()
  PCI: of: Attach created of_node to existing device

 drivers/base/core.c    | 74 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/of.c       | 15 +++++++--
 include/linux/device.h |  2 ++
 3 files changed, 89 insertions(+), 2 deletions(-)

-- 
2.42.0

