Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510688;
	b=LOzUR5+jXg3tlJLgE8XWiCIEN6qrqIxDGXEfdWpQQf1+p0VfHuqybhzo5j1qImu1XIkW
	 QJEeLjy+Wc5xlek01pCMwx/a9DO5Q7NXm1hICctLP8f3anH5pTgKYXOIQYiKsv9QZBOHQ
	 5W0FFGsQ/2kvKk9RCa5SutYoXyfm3RtHPYJCdqWybz/1MM0x686BH3Dn7TfjCIYAszEzG
	 oHdJmQW3GmG1v31qezmc9VxB90lXC7U0YWvTHQNrxY+pliuqNpQs4XjBRaIe0UBMTz4b+
	 I2FP+zwI0Q+IqEuUUqJ0V4FkvX6jAWNuWxwY0RteKkDl1XjPReuxRBG8pt0X3lag8EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510688;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=OzgY0qMkalxMjqMISRt+QJ29/uoiFUjotAlkjLoZR0E=;
	b=Mws92AejhWQm+vduPNqL0cVLCCiK9BzqV8WJu7Le0FUiaYNzpEY0wE4VBm7mdKql2lTF
	 O+xMoIyv3kC85VYfwnlR4J61bBFQQZv8IgFJ8IGRSsJ8xXD9JBjZpvXuJIMWK84wnB18T
	 LrsfPOV0Ygo8MutMQUcrpF3mdaG1ZOYSFMk7mjeR8cd23zkkUlxTIDE/uP7UJvKPzYJES
	 MG0n1uvcbJss1CoXJdt2FK9hzklYWzAncjLBE0QcFN5ct1MnYqK2F+3mW7lajUPaHsztF
	 WDXQITP+ssp9N7vqcJL41LXAgCWSbDzXiYP+0C2j36clsx4B2UOSPa5oJtLUVOfuGAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtatTUu8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32AA60A3813;
	Thu, 12 Nov 2026 19:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtatTUu8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FED1F000C4;
	Thu, 12 Nov 2026 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510688;
	bh=OzgY0qMkalxMjqMISRt+QJ29/uoiFUjotAlkjLoZR0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GtatTUu8xD/VbgFuyGkssHj3sYe6AK/K6252mPkJYu766rxF+dpDbm0ErXmM/Weee
	 ZP+mrzv+fz97VumYieUvgTrQYzNdbMXA8EA7WpGt+SEBf07aOpmFG+6EUDr9laltEJ
	 iCS68OpFLRfAIEcnw2D+8t+WolySLZo865dcKAx8zKafL9gNDYzlimqR4Z9Cf/ro+m
	 FDGg2+UoFwwJy7BT68Hwc2WXUJeJlifxs2Iyk3sHnpRY08nvRyjy0/e1ZbEGXMPMvb
	 ZUCwK0CBy6ShLm5MDYLuAvJkUzwReX6f94k6Sp3UOo5VjF6n3/jfZrzUwWpqqeIu1x
	 /cylYKJRvfaBQ==
From: Mario Limonciello <superm1@kernel.org>
Date: Thu, 12 Nov 2026 13:11:17 -0600
Subject: [PATCH v3 2/2] PCI/PM: Avoid D3cold for HP Spectre x360
 Convertible 15-ch0xx PCIe Ports
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-superm1-kbz-222179-v3-2-f20b5ac06b6d@kernel.org>
References: <20261112-superm1-kbz-222179-v3-0-f20b5ac06b6d@kernel.org>
In-Reply-To: <20261112-superm1-kbz-222179-v3-0-f20b5ac06b6d@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kerenl.org, 
 linux-kernel@vger.kernel.org, Mario Limonciello <superm1@kernel.org>, 
 Tony Murray <murraytony@gmail.com>
X-Mailer: b4 0.16.0

HP Spectre x360 Convertible 15-ch0xx is an Intel Kaby Lake-G system that
contains an AMD Polaris Radeon dGPU.
Attempting to use the dGPU fails with the following sequence:

```
  amdgpu 0000:01:00.0: not ready 1023ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 2047ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 4095ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 8191ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 16383ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 32767ms after resume; waiting
  amdgpu 0000:01:00.0: not ready 65535ms after resume; giving up
  amdgpu 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
  [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
```

The issue is that the Root Port the dGPU is connected to can't handle the
transition from D3cold to D0 so the dGPU can't properly exit runtime PM.

The existing logic in pci_bridge_d3_possible() checks for systems that are
newer than 2015 to decide that D3 is safe, but this system appears not to
work properly.

Add the system to bridge_d3_blacklist to prevent D3cold from being used.

Reported-and-tested-by: Tony Murray <murraytony@gmail.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3389
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
 drivers/pci/pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 17ec7f065682d..bced3a0e3e853 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3039,6 +3039,24 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "314D"),
 		},
 	},
+	{
+		/*
+		 * Changing power state of root port dGPU is connected fails
+		 * https://gitlab.freedesktop.org/drm/amd/-/work_items/3389
+		 */
+		.ident = "HP Spectre x360 Convertible 15-ch0xx",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "83BB"),
+		},
+	},
+	{
+		.ident = "HP ZBook 15 G4",
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8275"),
+		},
+	},
 #endif
 	{ }
 };

-- 
2.53.0

