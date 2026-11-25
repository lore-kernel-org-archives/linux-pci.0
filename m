Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628902;
	b=FOP6JQUu64kngxpWHrYpVWCpDkXMmv5C41sVzIMGuHCKiaNmMfusiWQBxlFRRlncEvSO
	 n2reTZojEU95cN88upS+VSL99n+RrVaq4f9F9TsIUzeodWfhxUqmq+3XZKYlDjIsP7KQD
	 pcqiaqeiE19W+eYRLGlNEsAbyC1i3HBeE85kkohQVvYMXPC9UgLDTFwPcYygCYUw9MyKE
	 qKQqU9qY0YvYyCVRYvI08i8ApM+JOhmSdBZ9KMa+8slFx8eFIMFzVU60prGuR4plmLquy
	 1Huz/I+jS44neoKSTAFnePi5VTVHZ8RAFs6mZnyiQlUw2qMkKJ2OMFe2gi5vGYPmtNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628902;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=0q0MLo3BGWILZ9gNyuQzc7su8itTZ84AHzV6dj/fCyc=;
	b=v9Nwz1uJxrr4ADjESV5hr8nM9NPHFpIUxTrUgz/J1ZnK0fx9mFYl7i5OC0cTkx+HQaOO
	 u967Z/HdZO7rgID9IBiBTW8YHh8rF835he/WMTFcHs7I49RIn9e4WJOeuIc/vEjpqw0uW
	 +zZYsW9kh9hwtfY9ldsJrDqK6KFPykhg78J5p1EEPSzYqG5oMfsu0QFbBSp+nEf0e5ppp
	 hQ/nu/YnM+DluBvgMfA4+zdHM68mvqCDxsrnkLhnF7HZbXk0Kwk3GzXW57Y6fqqslxKu1
	 WV3oQ0RYYtl2zgVdOcUsA+kf85m8kG6w2poG1qLb8vdFeW1z9kOe1B3VQJG+EVZiL6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EF2606A321;
	Wed, 25 Nov 2026 17:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6CA1F000D1;
	Wed, 25 Nov 2026 17:48:15 +0000 (UTC)
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
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] PCI: xilinx-nwl: Use devm_clk_get_enabled() in
 nwl_pcie_probe()
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Hyun Kwon <hyun.kwon@xilinx.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, Rob Herring <robh@kernel.org>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Christophe Jaillet <christophe.jaillet@wanadoo.fr>, 
 Florian Fainelli <f.fainelli@gmail.com>, Frank Li <Frank.Li@kernel.org>
In-Reply-To: <f691bbaa-ddb5-45bf-8f85-fcf354a6af03@web.de>
References: <f691bbaa-ddb5-45bf-8f85-fcf354a6af03@web.de>
Date: Wed, 25 Nov 2026 23:18:10 +0530
Message-Id: <179562889095.5580.5805178037943195830.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=613;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=oVmsAKPla0SSCmhlMgEfiLun7tvxgbJftIFjZnWKpuc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBrBx9frFFBxMMzmhhHbjIT7NtxqGHjr+aASXO3R
 AwMZBOcjTmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCawcfXwAKCRBVnxHm/pHO
 9dFJB/9chrc9j0yGBvYPUiJSXKOl8+2fWGrELXUciCWoJN7XzWm2ov7aOCjqzGof6ExhKjFDXjd
 RJIe2TsYOE3VBSxRi4fg7kveo3hepmJ8N5PldDkiPJJ3rhYzWw5wX9afZkrGkoK45Ro35TwAef2
 DXJxBSpGL3wMdt+wR/wTA9V8c/yBCU4AawHFprtwcrZIoGv19uV/KgsbGhAPbJkGnauqp19JD9X
 UfKMryv65/6uDeHRiExPLAEI4Ow33Xuovl2RykpvSrJ5LaVzEWpugw15cx9Jfu/V4b3L9QcQtTI
 WNYzYlR4miKw8U8qBnsEW+QGFFeZqPdGC4nkORJH7zB281z3
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-22 20:52 +0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 22 Nov 2026 20:35:35 +0100
> 
> * Reuse existing functionality from devm_clk_get_enabled() instead of
>   keeping duplicate source code.
> 
> * Omit a clk_disable_unprepare() call on an error handling path
>   and in the implementation of the function “nwl_pcie_remove”.
> 
> * Delete the label “err_clk”.
> 

THis isn't how the commit message should be written. It should be contiguous,
not bullet points and just say what the patches does and why it is needed.

- Mani


