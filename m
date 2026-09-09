Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C67592204;
	Wed,  9 Sep 2026 21:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988400; cv=none; b=hksJLRVMiH40fst48hlEMPuBmJzMa1mbBtMIW7iwJ/l3lzB3o02yIS8HmIi4Gz3gE/tnlTNQijAw2HsYraHlGcnWAaYRyN4BLfnqaK6EUntbrWKBKX9UNs1aOma0rznQaNXPOHGg+JFu6ggCw5zdTLEs+L35Dj7NHxditUgBQKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988400; c=relaxed/simple;
	bh=TLYWA2OlV0T2+Gnczo58khoYa/604KOFHHj3zSahl9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F//IC3UaaR4B0HClL3v8LNxXsV+H65hbfHeOJSJpqmMWJV1O3Wzrm5cLGL8//XIPQmMg/DTqbLMRkS2P9WWwLhl+MR/Htj11bW6Np6LV7p+p72LtEacvFmjGvDLvXAg0MBM9Ab4RgLjcjK/145Q57+8u+SZ2miQSe3LUq6lrd6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=YaEGx24A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m0hRUm0y; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="YaEGx24A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m0hRUm0y"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 55BB1EC02F2;
	Wed,  9 Sep 2026 17:13:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 09 Sep 2026 17:13:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788988394;
	 x=1789074794; bh=+krEGKyWZdbiLQJfkC7cSwjUZ4IQ8N9QB2a2oZdlosI=; b=
	YaEGx24AahtjTweL32VR0Jo+9ytT1tgPpDaikRiS/UkBjU2618DQk+DWeOjxij5f
	7Oqmhwyu8rj993bLY2avCvE8qlMdsn8BGhrkEfW+CnkQKHX7rvbi8kJg3oG51HrC
	IlQCeKlLppp8107sTlLucMepCDE6vymPmAmNNy9VmU4BuXzvl4nT//NJR9I8Mn6T
	cUvqAWbpJFJ5g66tcyOhgd7ScK9VRXTsbh6eVhH34jDABQ/6l0z9r56S3w8ZwHQv
	eYQmwM8G8WsIB403b68TNXarUhY69L4mBCVtja0QxHHz7RfdviX4NX5Xplttnv/0
	anp2j8WdXjs3M0mYRoBzRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788988394; x=
	1789074794; bh=+krEGKyWZdbiLQJfkC7cSwjUZ4IQ8N9QB2a2oZdlosI=; b=m
	0hRUm0yCAbamufTEfmUDWwExDGadA55VCATcbr7R5Mps9RJIKS2Qr31Et3SbFrHY
	KqRBsbTI0ZHh0/YiTa4HuLpOvb5cFePadvrKN1kvWSje4CcwtqJQcD5je6SsbK4Z
	Oe1yE6hvgbtEc5tTpOMYGOEK5fElB+fMQqpl+TCVz3VRbLbbKGlfHMwN5eZxxUWc
	In8HjNDlg//jlJ7FY+CYzgemKmt3SZqMeWh12/8dmLTP38TlUTdAZAqr0WroRnRl
	jSw9o0XjwqI2zij92zEe9a4E0AzHR3ZezJXnAP8lzRuEy+MboyUUsTGUT27puaCo
	e562BeNfrAwz7jjoy2Hug==
X-ME-Sender: <xms:6cuhav7G-98xMbE2qhFqJsTch5xY1Q6kST97hiaQInuWrJCxPII1YQ>
    <xme:6cuhagw9JyX1ZcphJQAMXiF4IEcl6gYvGjzfh0K87CSCUaFgToPatSRN5GTBtbx9C
    wFwUjKCGvmLYp86cLSetqk_ShAABEcQgy-HWy5E_QLGZZb9uv01S3I>
X-ME-Received: <xmr:6cuhah-tsco0drQ3plpn1hn0nT67h22TRc2WYKmig8GjfmI1WukgSEdWrXHaWw>
X-ME-Proxy-Cause: dmFkZTGWd2BOMV5duOy6hPXvUROs555RX8IHn+vyLCMNze+rE+pMT4sc0lKhuNwnW/Z63/
    AUPOl4EJDwi+nX6n6cHPkY39XJ3o+R+ICZ3qtTHxpBWDnSG51p4EOcjOlfz2NzZkhDD/9e
    V+N44n83k37mAry6e4kxyoncDSnofANIXE/27MZJ+3+a0m38tJQlKG0VYvJPVsXeYWFO7E
    LwuoqXTRdUgOcFuRvuH91HFMMfSmGZb3l39tRdNx0uhCNGn50e5vEYasnp1sjFOPCCub4S
    i/WWNZWxErDP85++ljYdsJWzFxDmDKrifQ7IQQGLqBl1vjeniuvSGU7812V8NVvXnTrqk2
    Ha/qZe70iV5XHR0C6C1r7sCkA/8B0ysggm0efNuKzjZBao5yQ7O8mbdx0SitM1IJIi6Hki
    mgRYh/Uj3N/Z6PfbNk8fO9h67CNK6StArV7j2sknCfgLO8oZgKzr9/cn5QWEOCYRXYve8g
    ts+2zpdiLaRNWUIZf8aFO2xIMlOAm/lsedxR1HQvCrYk9g3XGrORdvx/wyaaHV0ZH8NnfG
    4yA+Kczi4byEYpAQ9URD6bIIEQLC+m9tc25bmedeKy2qmOXh7wO3oOczm5ypAGcTt41JN3
    MtDw0jdtjJ/UrL+Vu+rH1jGZeNB01oDaL8Ocz0XGx9fciEwYqKvXYhBW208w
X-ME-Proxy: <xmx:6cuhakF6N731n4BPnkQW5Ug03p20r1sXsWY9K37O96NcHwlD40abFA>
    <xmx:6cuharAszfWHpVt1upRs8LoSzOqI-StQghwUAU_Pq0QtEKrxYCu4fA>
    <xmx:6cuhaom9HZEFwL0HtbB6HMPHrPAdFdn_g-ZYMku8WNUhJHyFKRBRYA>
    <xmx:6cuhauTqCBRwmuRs6Y_9fGHk2azgOChXAMYvnUXiQwG6OmgE1yasjg>
    <xmx:6suhav6S8MigK0zqQWks3msnSjBzT1UG9xdlbdQuokug8JH1YTEYPmrZ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 17:13:12 -0400 (EDT)
Date: Wed, 9 Sep 2026 15:13:09 -0600
From: Alex Williamson <alex@shazbot.org>
To: Srirangan Madhavan <smadhavan@nvidia.com>
Cc: alex@shazbot.org, Alison Schofield <alison.schofield@intel.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>, Davidlohr
 Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>, Jonathan
 Cameron <jic23@kernel.org>, Vishal Verma <vishal.l.verma@intel.com>,
 linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 vsethi@nvidia.com, Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>, Jiandi
 An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v11 00/12] PCI/CXL: Add CXL reset support for Type 2
 devices
Message-ID: <20260909151309.7e1883b9@shazbot.org>
In-Reply-To: <20260902072804.665639-1-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 07:27:52 +0000
Srirangan Madhavan <smadhavan@nvidia.com> wrote:

> Hi folks!
> 
> This series adds CXL Reset support for CXL Type 2 devices through the
> existing PCI reset_method ABI. The reset sequence follows the CXL 4.0
> specification [1], including CXL.cache disable, optional cache
> writeback, CXL Reset initiation, ResetComplete polling, and ResetError
> reporting.
> 
> The userspace ABI is the existing PCI reset interface:
> 
>     /sys/bus/pci/devices/.../reset_method
>     /sys/bus/pci/devices/.../reset
> 
> Userspace can select "cxl_reset" in reset_method and then trigger reset
> through the existing reset attribute.
> 
> CXL Reset is exposed conservatively. The target must be a
> single-function CXL Type 2 device with CXL.cache and CXL.mem enabled,
> and the kernel must have cached HDM state sufficient to validate affected
> ranges and restore decoder programming. The reset preserves device
> memory; it does not request CXL Reset Memory Clear.

How does this provide multi-tenancy then?  vfio-pci considers the
device to be scrubbed of tenant data after a pci_reset_function() and
I don't think Manish's series alters that.  Thanks,

Alex
