Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38811525A92
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 21:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111573; cv=none; b=k4GSzoN1ykRZxxdc6CMtTj/lS5gm+hDbOJWYLSwa38Hr4R5mRvb+YwiUl/AQLu00qMOFDls85iu6m+li7yVXigDMRHOZAfao5WjGu76u+x3NIF0RVqlmHTj0aeYS1QhAhn0jj8zZFGqiQdnYOj44OtdJ3yQYimatzmteidg/INg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111573; c=relaxed/simple;
	bh=9UC7sAjCZIX9Zt0NRB2/eLNEgZL17sCCSkn03eVrN0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ci8mwy46c960ZF6Og4GIKNLBBtVuLXTZqUBCyu2tKkVx2/+5MH4OwIQt7LXRNYigxgpTtx1/1AfO9U3gBXYorP/ygZqlSE3F4CEmN3DzThKZPcohrJus1ZNqGAVb57ONAEh4NVlY4LIrAsqVNTwX0kaFFlYqI6mgHImVPRiQN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp8945Ln; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp8945Ln"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1221F000FF;
	Tue, 22 Sep 2026 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790111554;
	bh=9UC7sAjCZIX9Zt0NRB2/eLNEgZL17sCCSkn03eVrN0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kp8945LnelQXQTZnDC9v6gSdkDZ6pJJvED2yTQoLRIWLHwDRti6RWXsbUSmJF+8fZ
	 XmPBdNVeMXqcrwFi2CFTcQeOaPjZZAI61lwTGJL/cAZT3aN9g3tg1paKVfpU8GXp22
	 UIx7VOqH9zS/lDRdsdj16D3QruLzxZ+IxCF5rkFRP0WhwFQ2tQXB1CaJ+VGdlpUXxj
	 31oIDAV3hYw29IWt8ihSM6iToD6dnBjkj/K4VQIco6MND3FKK8lYH4cv+ZjvxBL6ca
	 ueSUxLougTblbv2I2G/QoiyWYvVOLtovSIsDLFMP5XGHsHlWkJZ7JcxqD9eXV+t5Xd
	 ZuX4fh96l4RPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: iproc: Use __free(device_node) in
 iproc_pcie_msi_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fuad Tabba" <fuad.tabba@linux.dev>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260922210839.3765444-1-fuad.tabba@linux.dev>
References: <20260922210839.3765444-1-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:12:33 +0000
Message-Id: <20260922211234.4C1221F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Declare msi_node with __free(device_node) and drop the out_put_node
> label and its goto: the scoped cleanup puts the MSI controller node on
> every return, as the label did.
>=20
> No functional change intended.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Link: https://lore.kernel.org/linux-pci/61488ddc-b346-4ba3-b32a-e972a3bd7=
5a4@mailbox.org/
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922210839.3765=
444-1-fuad.tabba@linux.dev?part=3D1

