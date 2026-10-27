Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793101179;
	b=n2WGrvLLLokaKvIHcI7AyBmr6R4OYFJ58xUgb6wLEq4Hq5SnWQvnasgja9R+Dkp3wT4g
	 CqKa519itrMwQIJ74G8Ku/UXcVhHML4AwTi1SVGIj5Hp8n6AxfFWie4ZDvpI7JOqWHnqN
	 IHPNC6R97tnIGvkk/y8FvBOtSFYnQj5FfWQKqokaRv4jDicB2Li+/zoGuiiiFTXo8rTNj
	 V2KcExAwhfEycedGASs24t79CmW6XN741xbtCkXyCPTxl5Bz+xdJI7RNoeUBzG15RaDPC
	 vRrgoAQpbKUXBM7s3WJnoJb+PnPAfFhJ83Lx158XQN/nL+xKNfhi5UXygDueKU7aHKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793101179;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ESrymycrercx4WKj26TQ7uSZll8hEJb6wB1OeQMp6h4=;
	b=kWykNqz1HrjlWjPFWRRFNLCp9yWEkKSH1CkdL0a1rph9AYeKFNqDWqX/MRAovmG2w09W
	 s1eQ3xZgpSlfK5Ds6C58wS3WoxOGX0WtPhg9BaY5XB9Dg0NkRI9pJasOQP9r+VjCmi9am
	 5g7ek7heMfkMlxzUVTYfUKGBWu1CprIW2dDRMsdp6xlSlYSbRarkiBT7jm2ut/UAecY8S
	 U18k35x5OE7NPhImTWWGvIN9Y96nEDKN3n0e3k25CGwt9eLYPb/q15/tTRSOq0gCUyI3b
	 TanaSRb7OSEsUmj2J5HyiiV4cxQ2z1hUVvIpB48JYqzBEBzyMgTDBy58jdqMrzjLXtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2rTnLxW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD8606B5C2;
	Tue, 27 Oct 2026 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D2rTnLxW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9CE1F01441;
	Tue, 27 Oct 2026 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793101179;
	bh=ESrymycrercx4WKj26TQ7uSZll8hEJb6wB1OeQMp6h4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=D2rTnLxWreQ1s1Y6cgPUBRVLtKP6JYx2+VP+nxQNv+ttH/zBqn6TRNVrO4BgtCVmL
	 tkg1nK8xAeznPqS1pqWXKBdCmXnVNlXseqTH6utPH5M3go51Ab8vCls9tgNQypRLPT
	 bIviSrxGui+cdC/lk9EIeY2IxjBOiictbxdSipI424d3eF6UBpy+V2XX9B6tc0lXrz
	 XTg9vRkaUYk6UdP0vFlQ+cVUv0Ay4+xGKUwMbzbCGkxiUxrXMs57YTGeadLfbaKX8W
	 KbTgJOUwIHpiVSrLU0vn4AlDNEq5PydPRKq/ewB/gg07hexkpbVxQxbebkogkvq7YB
	 G556og/lLTaog==
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Fuad Tabba <fuad.tabba@linux.dev>
Cc: Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
 Scott Branden <sbranden@broadcom.com>, 
 bcm-kernel-feedback-list@broadcom.com, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, 
 Fuad Tabba <fuad.tabba@linux.dev>
In-Reply-To: <20260923180703.3901185-1-fuad.tabba@linux.dev>
References: <20260923180703.3901185-1-fuad.tabba@linux.dev>
Subject: Re: [PATCH v2] PCI: iproc: Use __free(device_node) in
 iproc_pcie_msi_enable()
Message-Id: <179310116074.5889.9680127168162481618.b4-ty@b4>
Date: Tue, 27 Oct 2026 17:09:20 +0530
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=345;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=AMfRuaK4nK36sJGSTedCARE9MAMDElaKKgH32J7UJkw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBq4I1wvm+ljiS61ncvUtkHNTAGJfy2y5saSepTU
 j4SfktlDWKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCauCNcAAKCRBVnxHm/pHO
 9Qw/CACCDBzEYt25olPXuF1nIV7tYt36WXS35jOKneSXhrBxNZEaoCMUM5CXDWPx1H3r46uryS1
 eoVjDr7BOHqL9+d8miPMDYgRti1HfbHkQA0jLKfe8cQos4nvIdD7VNtAsb50YxNo59pgAYegLnn
 eliaQ4hh0jgJaBIVkluiHBfGnagZ+SWaMdUIijc1e9lUhtwRbj8lrKrr37BhKDbDm0dju5fouk4
 90/9hG4dWN/QA5uz4Imf94X7J/2ZN/aegkyWQ9+3bwm+9//IBe4huQcvbHXnpyOepBQOl1Q2t/g
 Qu3wsWVc+XFuB1Xyg5l1zh0IecZFFe83lujk9jJwKebC4TJ6
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008


On Wed, 23 Sep 2026 19:07:03 +0100, Fuad Tabba wrote:
> PCI: iproc: Use __free(device_node) in iproc_pcie_msi_enable()

Applied, thanks!

[1/1] PCI: iproc: Use __free(device_node) in iproc_pcie_msi_enable()
      commit: f27468551f99d80c1f08be5194e9e520beb23908

Best regards,
-- 
மணிவண்ணன் சதாசிவம்


