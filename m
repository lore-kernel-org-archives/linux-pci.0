Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B2553C3CF;
	Wed, 14 Oct 2026 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987268; cv=none; b=TXuSpvFuxMGQOtKcAilYJ8ArgXp/ilHmdtXKhZMfQ0nV9WZ843mAaCrJ/voYmStThZK0BhfEZlyn+H5lHkLQnmat+yQQ48Kd1biEPWJROaRxc/Dl7dUq2/6lvBuPgjHYoIu39DSCORLhKOCbAb+Gu3fTvbVfsxj6q2t2YhCjvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987268; c=relaxed/simple;
	bh=4q1x69ZWSa0fMjs9T7WS5E496w6K4u80ZOnlPaj3mbM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=GznhHTVJMsFNsBtDyAlM1DkKAiO7/K/waaMupmN7lzjq98RwUWObwvRQojn1ZGrEM7XUXYS2JIiN9Q82SFWTnnosiHxZBlbIE4wCM4RwT5M97R3xgEHOnj/boBSLIlXnxqA7XhsqSfQIHfblwTh1Lh16TQ2+zpLZN5q0NQfKXrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 708601F000C0;
	Wed, 14 Oct 2026 14:14:19 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 03/11] PCI: tegra194: Fix Endpoint PERST# IRQ suspend
 race
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Krzysztof Wilczynski <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Vidya Sagar <vidyas@nvidia.com>, Niklas Cassel <cassel@kernel.org>, 
 Koichiro Den <den@valinux.co.jp>, 
 Marco Crivellari <marco.crivellari@suse.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260923072237.1139013-4-mmaddireddy@nvidia.com>
References: <20260923072237.1139013-1-mmaddireddy@nvidia.com>
 <20260923072237.1139013-4-mmaddireddy@nvidia.com>
Date: Wed, 14 Oct 2026 19:44:06 +0530
Message-Id: <179198724650.63727.14078621188562557208.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=753;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=4q1x69ZWSa0fMjs9T7WS5E496w6K4u80ZOnlPaj3mbM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqz44x4RXIN/lUMycJi7wEbu7l5iNrRkKqWWliO
 T3QzXTZTjKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCas+OMQAKCRBVnxHm/pHO
 9WGcB/4rISTg0m7mNpd9GMoYQ24YQukHjCYBb7UtE9FfkM8OKvjzfG/gtiNeZGFoKqNV9ZBk2V1
 IKmOpMqrP1rmfFgQqFtwCAooKy4tuz7M6hm45WS/qV1feQ1WQUA3Arqgad/OESAQoA+4n3Sj+Do
 /Y7MUc0lpr5Q2A6pEzDIVVn3l7i9bmM3HLfdPrIILR36t+29r1lmPELjii/8sJVVlKLlwxorubf
 ovXAml7OHEQ/RJp2fryZ2JP2LFpM9EApjq9DEY1n4ZJomUFFGExXrW9qipLWL6EK2hNsdKsdrhm
 xv/O7qKDEYQI72tH8lymY2syBrS/foNDcRxNlbuuMmjp3Rwo
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-09-23 12:52 +0530, Manikanta Maddireddy wrote:
> Endpoint mode disables the PERST# IRQ during system suspend when the
> link is down.  The old code checked ep_state before disabling the IRQ,
> so the host could deassert PERST# in that window and the IRQ thread
> could move the endpoint to EP_STATE_ENABLED after the suspend check had
> already passed.
> 

What is the issue in this scenario?

> Disable the PERST# IRQ before checking ep_state and re-enable it
> immediately when suspend is rejected.

So EP will still miss the PERST# deassertion anyway. Overall, I see this PERST#
handling logic in suspend as fragile. Since PERST# is asynchronous, it will be
racy if you try to check the state and make any decision.

- Mani

