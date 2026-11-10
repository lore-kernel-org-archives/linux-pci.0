Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343559;
	b=nvT4L7HJ0Y0vJiyc4JmbUa+SldLPytFDfmLzrhc3jEUhyjGZE5qkqcy9PJRrSHnNJzfN
	 0b+DvEyZB0UDYekVJoVD9BGRHzxj6NJPUCVxwsJpt7um4V0jzw+wWkmWySG5jknowGda8
	 UAQvmSirsjdlWMrQbEv0cOn6oSH90IZVC240uC/ZjST+S8eKOuA1LPvrIg0XUQU5XaBYH
	 A5b5mXiNpg6Ma407hWKt7QJiEFvE8FapfDORfomfK+WMIV2zW3p9GkfIDz8Pa4tbKWCnc
	 fayAtlRTou4p8jmEN5XCK6N8AQC2H3pZIgRyehgzSO75VxErlFPH9Xywnu7WqY9DLsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343559;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=X0uwa0HHW/pPPfmIj0uuwobwPe7kz9Vn5YZnvRHUgMA=;
	b=sNg/oiqNcUubkGzFVrQ1FY6mWbrnuiCwPv6E/D7Zb3Gt8yZyceVxaMi9VJvWQEm13fQ9
	 aur94JR6US5UCbf0JvJTZD9Ym1cNLDF4L+7FvrQNlXVJkJnUr1ho7KpGIDjCC5CKHBC48
	 w3trlTxkYrTlzj3bJ05lWbrdpmqHYJxDdDqgNr7hjGqP3mabJkzE/0zjrkOASSSMTEyiT
	 3uIkhvZ7+lUhudQgCuwi/cRh3c42PhTWegJmUGZ4/sBI0Sq3e8tJqVK5az9cnl5A3m3lg
	 o6xs+08p93BL/mVQVRSeUNpVcyazOpvvuBEpZcUSgtgRYoCu0tJQdxNIX5IYAHoLcMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byCLGSI5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F3C606A33A;
	Tue, 10 Nov 2026 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=byCLGSI5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638BB1F008BC;
	Tue, 10 Nov 2026 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794343559;
	bh=X0uwa0HHW/pPPfmIj0uuwobwPe7kz9Vn5YZnvRHUgMA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=byCLGSI5RVHrs/FXarQyVZ0URVZ72nGQLqSPNYDFv+NlGi9NJlGGsyhwg0AqJDfVs
	 IPEaKYhCs+cy6aF98/igsZ64vQnUMksk/lTOh+VK0ObasOW+QKbnXHxj0S5Zrt5d55
	 90bnuIN69w/i+F3XnED1bMf+iG+23+5cZ4irdchLuEoW+je5oSc0yHliRIiR6CSpQN
	 Qsk/DW9czbjx6SDQANzJBAVzsMCnRTUY7UdB4SQzr3fhmgS9hoiP4ZJhgVPK+XGLfM
	 6cctDCGgVnswhCiH7Z6ZNSfMw2zHqQ3tt7WKuq3RHd9uPRSWEpk7BSH3Ktloyq9EOc
	 axks4Y+DG8AGg==
From: Mario Limonciello <superm1@kernel.org>
Date: Tue, 10 Nov 2026 14:45:46 -0600
Subject: [PATCH v2 2/2] PCI/PM: Avoid D3cold for HP Spectre x360
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
Message-Id: <20261110-superm1-kbz-222179-v2-2-5605e6ce6454@kernel.org>
References: <20261110-superm1-kbz-222179-v2-0-5605e6ce6454@kernel.org>
In-Reply-To: <20261110-superm1-kbz-222179-v2-0-5605e6ce6454@kernel.org>
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
index 17ec7f065682d..6bd84b9809c8d 100644
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
+			DMI_MATCH(DMI_BOARD_NAME, "HP ZBook 15 G4"),
+		},
+	},
 #endif
 	{ }
 };

-- 
2.53.0

