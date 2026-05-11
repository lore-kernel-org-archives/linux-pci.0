Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CE447D945;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526997; cv=none; b=eWNkFEBRi1pQ1IYK/GoqndYW/PLsRadZFiKU7p6Vup0LfstJRqWQuAODxGZ3QQfiItL6pNb6TB7C3Z0jVQbTDDsPvUJr4E12uw5hkc2O00kGi+h/9L0J5ARyb3kD7bay3OX7Y2iNP2ULSBzuH1LArB/xrieJh1cHfzZaKle/fbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526997; c=relaxed/simple;
	bh=UVgrXu+uvoyPhcAmKsOvJjJdj9hhZ4efraaKIKdixQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H8MDllbHTVfndHRHrOBIX4A4CvSgtq1NdIebmVmM0sYqQI8jAnwfbn/MHsTWOL2GJiKCbHueZEcdQIHwwSCZK1YTj+MyQjp8Of+NNemQM8nnRn+yatlC5e6f9ZBDIi5gvUQFJvAaNQ3XFET10CNwbMhY4d/zOJvXhGfaH4SmKBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+k8XO9c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+k8XO9c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 386E2C2BCF5;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=UVgrXu+uvoyPhcAmKsOvJjJdj9hhZ4efraaKIKdixQk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z+k8XO9cAtxKwRoXpvhazb9Lp63bcRRSGxbB7YcrJ8tZDbnFZd8xjsYn5qFzFSqab
	 COHZ52iMofFCbhbC8hhqIkMG7mifGw2rGSIHSF+LmnFL0T8FBL5UxxBeIPPF5tg4C/
	 weQ8uoT3mjjCoLyQo9plS73FEsib4YkQZvBfUWyvkVG+Y6c/f5iFXuviaSC5N005an
	 OjBEP6tg4EIPXpLgPeFmFIrU348a8ynM9JJ+m0zKHrujctdkTsdJhM2mJOzA4gtBAS
	 aYMbnSw4SCfvxDMUmcvvtlh+KsNJIoeE/MaobFIZyaL/L05k0QZzD+Mk4LNIjx9ex8
	 H7KUkAGfH9DkA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD70CD4840;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:13 -0500
Subject: [PATCH v2 01/23] PCI: Add SNIA SDXI accelerator sub-class
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-1-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
In-Reply-To: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>, 
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=777;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=gT89JbxFXf7gHxa4CFTowkdPFznCptvO0Axhku2MaJg=;
 b=kJrY7wP5x8dNrEvdtWI+fsvCtk22kgMub2Zu6zDJIptDDotn1uUYjm2lvvjLgLgBJ6QUi3iuY
 6LKTVwYCg3fAnsMWtnmyZL61g/octJ+aj2sPZa3qTzZeSWTUmyjH7ml
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add sub-class code for SNIA Smart Data Accelerator Interface (SDXI).
See PCI Code and ID Assignment spec r1.14, sec 1.19.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 24cb42f66e4b..83ab3f27eb5a 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -154,6 +154,7 @@
 
 #define PCI_BASE_CLASS_ACCELERATOR	0x12
 #define PCI_CLASS_ACCELERATOR_PROCESSING	0x1200
+#define PCI_CLASS_ACCELERATOR_SDXI		0x120100
 
 #define PCI_CLASS_OTHERS		0xff
 

-- 
2.54.0


