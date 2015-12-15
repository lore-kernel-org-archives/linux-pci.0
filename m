Return-Path: <linux-acpi-owner@vger.kernel.org>
From: Andy Lutomirski <luto@kernel.org>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Yijing Wang <wangyijing@huawei.com>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 0/2] Minor _OSC error handling improvements
Date: Tue, 15 Dec 2015 08:37:38 -0800
Message-Id: <cover.1450197207.git.luto@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This time, I think I'm sending to the right people.

This doesn't fix any bugs, but it makes the debugging output a
little more useful.

Changes from v1:
 - Added Bjorn's acks
 - Split an overly long line

Andy Lutomirski (2):
  acpi: Tidy up _OSC error spacing
  acpi: Show _OSC UUID when _OSC fails

 drivers/acpi/bus.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.5.0

