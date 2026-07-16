Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564503F822B
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 14:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784210932; cv=none; b=UTEnbia6NuMF615fJcNP2TFQOKt+LknBu9mvatL/pNfWDIc22p3Aw1jtQSOW14oq9UtyT+nfS8HCfKzLMJnVFVW3SfDigyNC7W5rrENvqXaYLybqF02NbNGm6XPSnmADMcvMohq0GRSzmNX7pq/383foIrl950tWqoiP5syauWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784210932; c=relaxed/simple;
	bh=48X8sVZ47LFFwU3pbsqfxxompYl0yRhnFoGDPJ9/sQ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fVjB559Cz0IwBZKa7cW3mOvMxikOUGkKEWu6cS8N4SHfI3/hQF4W5Jy/Ngh1kg66LQ2j1ING0i6xg5GTHjZs5CGAMDHQFgdXrd3NvZp7ojS6Wvg2iBfFWlqT+fVICCc0ntdnsKyjpe0CySIo7W1Pa49oy2jHLduZa6+Gro/SSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRwZ1XgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRwZ1XgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 048E11F00A3E;
	Thu, 16 Jul 2026 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784210931;
	bh=48X8sVZ47LFFwU3pbsqfxxompYl0yRhnFoGDPJ9/sQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YRwZ1XgM69LDQ1Yjqjjp4d4AGYvN22rD2MTSR8eDXzVmXSkj3MkMq8euEtzIMMd8P
	 g6uXqw87Vh1qOYrWjQTUIC42gQ8jw8yJU4mimZHnRthtgFYTkfDDgoh45Tb0K/sKwd
	 ATWYPX2LS3373dE8jz8jCaYOkyvClkk2v3UsCFYqG27xpvgOIzZN9l5X35mGdrUSA/
	 Ely6Obpb+4VzhsB8Yo20RfZtWBn8rJTqVlEifQTLrDZIJwuleFvElzpZiRXO36Zqrk
	 VxqSWXH1+4S4Oj/GVGHWWjtu+kI7HvFKyWV9vw06+RKbjVmL7gJfRb8jUWtC85BRno
	 Ciiio4epthq4Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] ACPI: PCI: Use a mutex guard to simplify
 acpi_get_pci_dev()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <3056272.e9J7NaK4W3@rafael.j.wysocki>
References: <12935400.O9o76ZdvQC@rafael.j.wysocki>
 <3056272.e9J7NaK4W3@rafael.j.wysocki>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 14:08:50 +0000
Message-Id: <20260716140851.048E11F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>=20
> Use a mutex guard in acpi_get_pci_dev() for the physical_node_lock
> locking and drop local variable pci_dev that becomes redundant after
> that change.
>=20
> No intentional functional impact.
>=20
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/12935400.O9o76ZdvQC=
@rafael.j.wysocki?part=3D1

