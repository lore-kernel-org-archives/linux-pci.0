Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349179;
	b=DOoL8VronzRqaVXVQGiL9ivCDwQP35GKUoWTeciEtGjviiS7e8gsBjVni5PCOgHYEcIP
	 7wHLW64WYNF2hPDMk0YdXKiFWk/dN80CwGvC82y4hFvihJB6xQLOwyEZmnLW4/9Qo4kwD
	 c3G3+XnhC5vbdJTMVwgVqYfVFBw4OzfASyvdTsv58H3hvVNlRbrrhfLhJgsoz1chbi41O
	 PX2Mesc/wQcd07gn412rWIDlvIHCOdSVHVHxZlA5l4v/MjTETlzeBFrxCpjI5/FEpLjxf
	 W1I+bxw3aQ2kcooulBb67TTegReAByoCLVEXEetuqfu7H8hpE48byLSOECBUdQMaAkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349179;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=hHoss5Oln5FdDLhYeqtmeMJg1bOOtVhza6p3OV4GMqo=;
	b=kgopOojumMf3dn3x3Xc3/98ofNYcpiDdb6ibSvKPrlbIeUVbdwFrJuCt5keuFudffzxr
	 ELjpjZpC8fWUm4A3r6aO523M/3728nwqa4aQEkO9mLgmXm3kPtUfsW6HCBVd4hrAUIOiE
	 RWYkNW0dZL1Ixx2J2ti/SGRE6s3psm8ssrassPL0/JrTVwn2BTfHaBrss1quyU3H8Xzfk
	 WIpLi1c1HL/+lofX4CUDdfHkP76rtwUZs5la2kECZjrg/k0OBpLnRaURqfXvh1g7D4Z6X
	 cIZAdzDipqmeNjNIR7x4gTHvRMVcT9q7qAHaQPPmbckogr5+jpGgFD55DwgvubQE/4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9B606A31D;
	Fri, 30 Oct 2026 08:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD7721F00A02;
	Fri, 30 Oct 2026 08:32:51 +0000 (UTC)
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
Date: Fri, 30 Oct 2026 14:02:28 +0530
Message-Id: <179334914849.5551.1603828369243192858.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=803;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=WV85bBS6bw9CaG0fNBFSs3bmsVLXQ+ykDnrjKmlaBqQ=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq5FYtxXMsWz3zb6YFv/+yJ3eUli6A80DeCB29m
 bpaxVtRcSWJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauRWLQAKCRBVnxHm/pHO
 9UZyB/4nkFvljX2tb9WW0Wo541ySMC8n1Y32dNiq/7b0ncmjeWthPM4HoT8w83TNg6y1E6jKem3
 M0OghoAY0k2tij+L8eK/+T2/cBqB5mwnhkQdvo2CFBlXVssGVb8Z80gXkW6VQbqpD3YGhQESL67
 8MfhB7PH/RdNXBC1QB8YcwLJ6MS6OAXjCwF/oQopoFKv7RFUeCjq/CQzx67xnwag1RG744BfpSH
 4jx2kLweskIgehIB0qxYvai20/h3Dh8GvauEJnoVyJQP8lUJFu7aMjJQ0UK0bqfLy0323PHeMLl
 o/mEBdolNnZpLDP0frDM8tCJpbF4mbhptbqYLEDghQJKQFg9
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

Series doesn't apply on top of pci/main. Please rebase and resend.

- Mani

