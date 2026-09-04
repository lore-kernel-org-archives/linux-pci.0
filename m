Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D321A6807
	for <linux-pci@vger.kernel.org>; Fri,  4 Sep 2026 03:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788490873; cv=none; b=LM9cOc2L8L9kFiy6LjCVe7gqZY2s/NhIQmgd66UQmltZZoLKirzWDwwbUJIn/xV8ytz3AnQBl07tgEmnt2VuoEd6eq6iswoetb//L9xhmud43/EWBFaAIt7PJhREgWvtfhMiMgLpLK0OC7TQ5VAd4hSfzN6b23sFizkGkWLLYiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788490873; c=relaxed/simple;
	bh=5RezhvZ2WkTxvH3CJ1aOcFeDg1l3jBOO6ZQlRPiWEnE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TOzRGtfu4TMKd7TQ0raTTHmHN7phUrOzNzv5lIHJbznPTR6GzicVSgZxQ17J6zKz24DvEeavQT+KPUEiWXWD7BTv3NpZXK+rqtjzS2B941iTTR+AADoVRl/1LYErH+LzOUvjeWQalaUsV2sFhEihDq6oEHfLFX+7T7Cl5+fOohQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9hQ60nX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9hQ60nX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 751101F00A3D;
	Fri,  4 Sep 2026 03:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788490871;
	bh=VYryuQFFkBHoPIIrE8RvL6DL0+xhw2JFOb89+WwJQDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9hQ60nX+QfxLFFq2/alkhiregXTOpTP8GoOikN58uV7j7uVcSs9OEiaItVGIJPeB
	 tttZCP8CSWzNCVSKmFVvBMUcicKti3xUO/tRigj5XAjd+zz++a5HnUWL5ttcCffh9Q
	 No3LpNruxscnsXyce2qoBaU0ha72cT7c9c8LtQWcU/Cr/W0jEAtC0CVENSsLOZHePT
	 n/3sj3SRDcPUyAvS3REbyCCW1ykAcuvQQXAQz51z95zA6mASP1y5QusGtb1Wo2r1vG
	 6PliHYvKFxN9SL1WUY2303zHMcKJeu+3GFNmUSYoHIzZZV50fBeWU/HnNFExzifsny
	 hWwlcbIx0LkBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Add pcie_get_link_endpoints() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Priyank Rathod" <rathodpriyank@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260904-pcie-link-endpoints-v2-1-16fcb301a3e4@google.com>
References: <20260904-pcie-link-endpoints-v2-0-16fcb301a3e4@google.com>
 <20260904-pcie-link-endpoints-v2-1-16fcb301a3e4@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 03:01:11 +0000
Message-Id: <20260904030111.751101F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In PCIe topologies, physical links are point-to-point connections
> between an Upstream Component (Downstream Port, such as a Root Port
> or Switch Downstream Port) and a Downstream Component (Upstream Port,
> such as an Endpoint or Switch Upstream Port), per PCIe Base Specification
> Revision 7.0 / 6.0 sec 1.3.1.
>=20
> Drivers across drivers/pci/ (such as Lane Margining at Receiver and AER
> recovery) coordinate operations across both ends of a PCIe link:
>   - Lane Margining at Receiver (LMR): requires resolving both link
>     endpoints to establish hierarchical locking and runtime PM pinning.
>   - AER/DPC Recovery: identifies the parent bridge to coordinate link
>     resets and recovery sequences.
>=20
> Introduce pcie_get_link_endpoints() and pcie_put_link_endpoints() in the
> PCI core to provide a standardized, symmetric, and race-safe helper:
> [ ... ]
> Callers release acquired references using pcie_put_link_endpoints().
>=20
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/linux-pci/20260831214631.7CD5E1F000E9@smt=
p.kernel.org/
> Signed-off-by: Priyank Rathod <rathodpriyank@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-pcie-link-=
endpoints-v2-0-16fcb301a3e4@google.com?part=3D1

