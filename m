Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB380435AB0
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418293; cv=none; b=hrLJRJQPB2bH89mrRuK6Tr7mFSThnf/zpaTrmqzR0iUq2nUalO2qhVoFYB88yjptRU40QDnfE9EYQcxAQlVWgdonlKGiJM4zxkQnAyk+53a2GM/WpbS1TkbKagM15Pl9H4ixDo9B5yHXNkV2yBaSyQcw0O3HeF7M9YpumjtpC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418293; c=relaxed/simple;
	bh=zgXu8CLq2aWhaEA9Y29aCX4eax5/t+t/rOgFDgqxQtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckKGq8BkIfZaNEYlUJm/akR7KH4s3ySZAHDp02UFLXeePrSLkLtZey7V4eKAOgxoA0Eh/RG0HxS3DAScPctLENSZnzpOmfyAQcP75/rZo2Ufnvw8bpEkKTrNirGZYsEKmMEvlCnZ47LghroxWfUgb8WNXw1o8otkCtmrYcNRsqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RanoqPMY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RanoqPMY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A731F000E9;
	Thu, 30 Jul 2026 13:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785418292;
	bh=k3IoTi7QC7zwIjnWspq969gfmvLdg23fIo2ijqATBh4=;
	h=From:To:Cc:Subject:Date;
	b=RanoqPMYeDsGxpRg4MIx0s1Aa4GnG3T5aq1hm87o9U10NRIW/ChidCYGI4/ghS5Fo
	 /Gp6bkzG5RtbqyZEmVyO6NKl62YF78h9/63JR1aP9eALV9/N5jKPKcMHVcUkoLGAFa
	 Xy5vWO8ARrokR+Oc9uv7wKAyPQotB/SCjlLzmUb10Mon9VQCaZYrIdpO+A2nCaOpgw
	 9T0ucydSPQ8+gxxU/RLelfSaEiLvNUHxDFgjLb4Di4WtEx9JgOrZL2xJNvEqrD+Yp/
	 sb+sA2Zp/Qp/MZW6sPItW9wkCAqiEKzblkEHj4VZqLN2WQH0kK5ScIsymicVcX2usd
	 vTwNbXJNUEJlA==
From: Niklas Cassel <cassel@kernel.org>
To: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
Subject: [PATCH v2 0/2] PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU
Date: Thu, 30 Jul 2026 15:31:24 +0200
Message-ID: <20260730133123.1420413-4-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=526; i=cassel@kernel.org; h=from:subject; bh=zgXu8CLq2aWhaEA9Y29aCX4eax5/t+t/rOgFDgqxQtU=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLKyg7TDJ6i92PZ1r0lpt5aERPHEp2KH/7387uj/aN2Ua Osy6XnsHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhI1QqG32zpW5bvENe58sv0 062wsHSX0y9vvk1snSJ4fdENox+5jxUY/qcJ/E/c/Pb4G+u78T3HIq7pRDYmn7k2u995lWehs77 3bA4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Hello all,

Here comes some fixes for MSI/MSI-X unmap problems in the DWC driver
reported by Sashiko.

Changes since v1:
-Added patch 1/2.
-Added a flush in patch 2/2.

Kind regards,
Niklas

Niklas Cassel (2):
  PCI: dwc: ep: Flush the cached MSI address before unmap
  PCI: dwc: ep: Fix unmap potentially unmapping the wrong iATU

 drivers/pci/controller/dwc/pcie-designware-ep.c | 14 ++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 15 insertions(+)

-- 
2.55.0

