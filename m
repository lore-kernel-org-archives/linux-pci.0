Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793340780;
	b=uMG88jB5GCHP+eOib3HZ8S3lnCGcqV3aUrhg3BzXsiJiPwHcZJ3syHXk4IoMF90UFEuE
	 vzZZaMMOeKGjhU17Pt698O9ipBzD/Sb6M7ADQIg0MzR7CxDGBWT2WgxydAzoWqIEAaA5S
	 P+/Q1vjJzZQZyJBc2tKasiJ8RWoogsCa4Glcxt9uPqO8aJ/GrLUGoe+pVBY06zb602dhn
	 CIPOWlxbQjEJAAL+QsbZulfuFEBctpoaJEeYtoqu7yQwffZmggFyeCZSv7VR4VSBRiACD
	 8PqTQtR34e9VV5RQl9xJt6Z7b3VpGVlhrChBEpvFsV77W0z2Y+C5T9JUWwmxoZVVRvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793340780;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=pJri7Pt0vkX8NQbnwxRAfr0XabvPu+sHqkn8juBt6Q0=;
	b=4qE04euVMkrjZ7Th2vM2RBsaEObXpMP+idVw/sHskDOlAbi3Z4cMEPY2vC3FWvIEJU31
	 RUkAUE9vRJZfkd37BFjwp5xfEVyNZ0DPRDLKk95VwsrPvaGdMKt1vi852N7sN7WW2ZeYg
	 bvgTjvNfMBWeFJRuKRaUWGePgTM4pSPJlTB6wVVbxAf82x2qDM1vX58wAdYQBTQcfXO1w
	 /J1iKCTn0KW+ePOrk5wr4CWfQVevYSnN1KKOiaFK/okjUUMrq51IXp4TBUnSViurbWZ3r
	 peYhEqWOpdom2monap/TQS1mU3/DNjiKvT5ocGhwzn3s8sJq5E17lshALpHYNSIeliA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5743606A31A;
	Fri, 30 Oct 2026 06:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27F31F000C1;
	Fri, 30 Oct 2026 06:12:50 +0000 (UTC)
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
Subject: Re: [PATCH v2 0/5] PCI: dwc: Clean up RAS-DES and register field
 handling
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc: jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org, 
 kwilczynski@kernel.org, bhelgaas@google.com, linux-pci@vger.kernel.org, 
 robh@kernel.org, thierry.reding@kernel.org, jonathanh@nvidia.com, 
 vidyas@nvidia.com, cassel@kernel.org, linux-kernel@vger.kernel.org, 
 linux-tegra@vger.kernel.org
In-Reply-To: <20261016074026.564302-1-mmaddireddy@nvidia.com>
References: <20261016074026.564302-1-mmaddireddy@nvidia.com>
Date: Fri, 30 Oct 2026 11:42:35 +0530
Message-Id: <179334075515.5551.7641942208604764986.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=760;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=WwWrHmwokDDvDkvbO0y5DAJFcZ+v1xXSUHLrf318sVE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5DVhrC66iPKsvd2ktzsu9AfqzeVf7KtHo8zjh
 S/fTNKuZtSJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauQ1YQAKCRBVnxHm/pHO
 9XsvB/wIjNvSYF5lpvAs3yjrnJG9FdaB9k3MRpuEsHORdXIEXcHDt1KzBkUwrcGEkabNsoRg4/M
 pR1UMPvVsucXE4lZsd8k61V/OQzz8Gpb0bD7x8iLJI9mgLrUt4TVggiXtlkMN4k1g/I8BEpmdxa
 OL57BWzHFEAGW1zBWkoH+5zcV88TQlHv/EWncQoRZi8FW71x3WawvHqIh0rShBpFePFEWussFYK
 3oWoch1JxbjKSZL+BZhkHO90b3ECeA9cZvP7rE2hxaUmpfu4R2ZXGBjrJ/vR6+0y6qcleWWTXVP
 pB0RYJTIfapDyphobg/NogS34RH4WcTqoIIrWCJtg79YduYJ
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-10-16 13:10 +0530, Manikanta Maddireddy wrote:
> This series addresses review feedback around register field handling in the
> DWC PCIe code and the Tegra194 PCIe driver.
> 
> The first patches add shared masks for the RAS-DES event counter fields,
> convert Tegra194 register programming to FIELD_PREP()/FIELD_MODIFY(), and
> drop shift macros that become unused after the conversion.  The final
> patches make Tegra194 use the common RAS-DES selector definitions and
> consolidate the event counter field definitions in the DWC header.
> 
> There should be no functional change intended beyond making the
> bitfield programming explicit and keeping the shared RAS-DES definitions in
> one place.
> 

Where is the changelog?

- Mani


