Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627859;
	b=skBDVqGjME5tvqpMrB5ff6Kq1uKu4lEUw3z3i7pKBSbJBwKeG/kgTIcWkk8BSBolbrTL
	 i4Z9Wui15NdR9edMQdKDK2U+qi7f9B1sChQX9GWpuWX9QmizG75qutwe3Bl3u3oktjbVn
	 5vNTMMGrezYH6rdiqBLa1xQ0aLbpJWNx8qpX5l8bit5BZFsE40S/kum4vYEZxfryY415L
	 ybb2cCeVYA11O4HaPuNNNeNkZK4OkqkHaIhP/xTI1CsAvKQt1xCkHoR8UADnxhZP6qsBg
	 zX2B7lp836VL88ZpknGkAXztWFznyKjTYO3bFAo0iJPZF6SkSOXRJD/caSTOndGIZPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627859;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=g/d3l4uRz3VVvvzQtSKQeS0rX1+LEzn3UqvsIOfeNjE=;
	b=BU7GSg6TbIDQwTbuM8bkjKcBIw1W4oIoGHy9R5X7QB7ppx/XoOLm+KK/Gj7UgbvO4Zgd
	 c0N2mgvjRfk/IqibG38nH5LJpad6joUSp/vz6SInRAbsXcg73tLd4muC3ueV2z3XLj9uC
	 RFW71SWBEx1wreiZdOAoghfnOY+er34BHUnGje+PMnMa0L7IN7ZKfrARiC6uhJBnj0Hxb
	 ngQ9TQdADrI4Zc79n59NZs5DQvw87Te8aMQBnLCt+zDiLtIw4iNGaMSLJBfekJz2FaNtk
	 44fiSOrOgUWeOrGzAXCgEZVsxfDrcz8N3SV03jUuDQWnteZXKJQ9+DkpUzcirQOaTJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qdc4iBCm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727C760A2601;
	Mon,  2 Nov 2026 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qdc4iBCm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D231F00A17;
	Mon,  2 Nov 2026 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627859;
	bh=g/d3l4uRz3VVvvzQtSKQeS0rX1+LEzn3UqvsIOfeNjE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Qdc4iBCmu+TFL+Y375yh+OxDUn+L6gucnlRgB2DGEmS0jzATgnLwTIn9rDynAgVl9
	 qjoMKRaOAHdKf2oiP1rMdo6/wk4HH+xqDzLyxsp1U21WDi9+mOBkQuznZ3Ph1Ro9ga
	 2WzkMQkhuTcGwabwbp+HxlXcqgMXS8fp5pHNHhUsfSEDCimcPfWfK2vjiZK8lbFdmv
	 qM11iUqCZ23bekDRqAzcTlcfL8+kYOa3b5INph80m4W/k7RjX+oIsiDD82ygTxvdLx
	 v+NvJoGKfkzRSZ9IuE7C71xKeEvSgBWMBZkm2lOOEcwNPlC8TfVUDcvjCUwyml8Ou1
	 W4qUKQz5hWzDw==
From: Mario Limonciello <superm1@kernel.org>
Date: Mon, 02 Nov 2026 07:57:27 -0600
Subject: [PATCH 2/2] PCI/PM: Avoid D3cold for HP Spectre x360 Convertible
 15-ch0xx PCIe Ports
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
Message-Id: <20261102-superm1-kbz-222179-v1-2-c91a664ba251@kernel.org>
References: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org>
In-Reply-To: <20261102-superm1-kbz-222179-v1-0-c91a664ba251@kernel.org>
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
Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
 drivers/pci/pci.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 17ec7f065682d..151b98757ba57 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3039,6 +3039,24 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "314D"),
 		},
 	},
+	{
+		/*
+		 * Changing power state of root port dGPU is connected fails
+		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
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

