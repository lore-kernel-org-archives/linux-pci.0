Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794088253;
	b=UXXRCsHhBxvL6Ky3t/lOOZknQfEwlklbt+yvJfqnieDG00JRKgve8t0pd4ZohSqexxS8
	 bv5oF+ozUKUKhOIhwJyCoC/bPTZF3lsKqEMxR05cEWFxrm+Ac9tYNOiIlBA+rGdi3yBxU
	 0TyLtRWLoA6U23a5t/X9AWmWWoi7y/wLGWnIDVubFhqrKdI9OApfc7et24syUWmpP2Gdv
	 vTezpTnzCHYHNpzc+LSMgVVNrGMYbsfd+TXi/dsJ7v3Mhht3/r9jTBCpOJ/kyG7hQN7Hv
	 fs1v/p7ms1J7/LmZewlCchOTBFP8mmoT5aArOhfWOj2aLpbbxz1+gW9IJriKYejop6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794088253;
	h=Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:
	 From:To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=5zaMIdL/oTvgce3uIdLspYmw2AFfPjykQ6u5nR70LZg=;
	b=F75JloroP3qvtppnDV9msFaJRNSLfHIi7X+S4fP8nuRZk2QF5c+plJVlOuiR0Rd+CnFv
	 lpfaJtIDOy0dJGB/jJEj76gYlep4WK1y8y2NKWiouQmNk6/7HBKuEBOeEI6BYwCEMoFon
	 tWx17xBYS97cVTeQ9L+e4cNoNSpsXL3NZyUP3UbFH55ERUdrtOjGTva4IE62U5ZtCVToG
	 g4HLOUVPDnTg9o/Eq5mxoEOTZ256ZZ6wytbczFP1hcuVCwRrRJStobcgjcw6fz3pyPsee
	 3UhhKFUFh549H0Q89o4TXVyfqPp5WjoWlxb1nwqjVmzpSq/fbUsjPgFLDbhh/lPPA0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F22606A326;
	Sat,  7 Nov 2026 21:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCB41F0089F;
	Sat,  7 Nov 2026 21:50:44 +0000 (UTC)
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
Subject: Re: [PATCH] PCI: dwc: tegra194: Clear event counter masks before
 programming
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
 mani@kernel.org, jonathanh@nvidia.com, thierry.reding@kernel.org, 
 robh@kernel.org, linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261102063835.3831940-1-18255117159@163.com>
References: <20261102063835.3831940-1-18255117159@163.com>
Date: Sun, 08 Nov 2026 03:20:31 +0530
Message-Id: <179408823130.65886.4565928376292834631.b4-reply@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=795;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=dakCt24LNGbCorjDl0SmM+0y+x3kI7kpyH6lmNNGVcE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq7500UgByzF3S479FykilCzs9qrlMrpZyj/IP4
 43wW2/PW+SJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCau+dNAAKCRBVnxHm/pHO
 9bBLCACd//rdiTPNGlhqD+1qZd/vmvclbugxqXHq5R8PMLfZBbUSSj/4KUe7m7eqIOcgB6bAlby
 Bp1/XUfjEw54bY5sW/4cyVC4l4g0pT5WyMoa6PkoTBpEcMf9j7SPRK3WWHbDxbReLIxCK/UKMvb
 cYp7gMJsGpMQrc4hDetC4n1MFAxC1IyHuUKHLDc+MPxkPCP3ju2atPCYSK/cXeXQX6Ik6mKfyiz
 2PkCcT/ddtc+VdgOXE3Jy26uIuWOesen33pGIKbt1mej+pbWW7CjZJFHNUF2kL3rc7wTzZ6N5JZ
 rHRhOoM0wEbMHXear9DhqS7bZfouNaWmw0y5/e1qujYn1Tkp
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

On 2026-11-02 14:38 +0800, Hans Zhang wrote:
> When programming the RAS-DES event counter control register, the code only
> cleared the event-selection field before OR-ing in the new group, event,
> and enable values. This leaves stale bits in the group-select and enable
> fields from prior writes.
> 
> Clear all three field masks before programming the register so that stale
> bits are not preserved across updates.
> 
> No functional change intended beyond ensuring the register is rewritten
> without carrying over previous field values.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

This patch got superseded by this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=fe84c0b370889bbf65f75bb75a1810227c7ce150

- Mani


