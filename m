Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113A1456E14;
	Thu, 13 Aug 2026 11:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786618926; cv=none; b=IefBAfZllUMWEM4o8EXsoKNNNpASe72zAnaDz6WihWWI9OKN8HjDS6WePPV8McwzA/07PmsTa3Q6kWamFeFiwvJCH4Kb2mUOV88r5YnqKGCZKvyDR67vTtXJUDaEYSIREMTiHmyy4j7BXlDYvjR13FJx7mpJ9qaVK9Afn3PS0OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786618926; c=relaxed/simple;
	bh=uyvAJ22j3bAxVZedSMu1+AAovxcul9gWm+L7qHGS3hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YijLp/vvJlhrREWToiih6djLU5BsetKIHX+l7aGAqTHIQAoVmzmPC01NGDgIIa290e2evyCNFNI/0AUJyrfUrH8xe4KBYXcEl81hbyYZjg5GQH7WQM6gGA0i9zzsgISFZQutM76ymHAVPgflzz6cA/9R+LH+qo6TmX5JB7K+RUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yb11xnrW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yb11xnrW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CFA31F000E9;
	Thu, 13 Aug 2026 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786618920;
	bh=1IJiqXRv0R7jZDCWDK/+qXMkKe/8L84q23UBUb8Y3bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yb11xnrWwVdHWY2xR2FZkbqY7mVUWa/NYq6gYnV0dvU+5brVt4MjL1D8f/usgH5wM
	 um6LMoFc3KGCiObYGA46AE5dWNO+Es9kpfApXQKmkn2XPk1ANCVZny52pOnwh3Wimh
	 ncoZOiORrkAweDtY5VoUabtmbvHeq6aPg8VVH/usM6W7vOKhjsVSpGD4RAX6x/Pd5a
	 pnYj1+qgPsKW7cjsZ6hHjF/O4d7DjpddpOsQB5w4JN8B+++37rDxl/iOy2njqUGQm+
	 WATpFs51o4fpSGmnNtf+jCFXT3nDqHzIYVTowzD8Iw8hgJQlByMsVJ8hz+olBL4PdW
	 iwBw/B+gZt0yA==
Date: Thu, 13 Aug 2026 14:01:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
	"Natu, Mahesh" <mahesh.natu@intel.com>
Subject: Re: [PATCH RFC 1/7] ACPICA: Define PCIe P2P latency and bandwidth
 information
Message-ID: <20260813110153.GB79153@unreal>
References: <20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com>
 <20260812-hmat-p2p-v1-1-75ac41380585@nvidia.com>
 <CAJZ5v0iDR1LN=6QosMvNbctHKqEmzG0Jg6eS1np5MQkfLjXzAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iDR1LN=6QosMvNbctHKqEmzG0Jg6eS1np5MQkfLjXzAA@mail.gmail.com>

On Thu, Aug 13, 2026 at 12:13:39PM +0200, Rafael J. Wysocki (Intel) wrote:
> On Wed, Aug 12, 2026 at 9:48 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > PCIe topology alone cannot tell an operating system whether traffic may
> > cross host bridges, what ordering rules it needs, or how expensive the path
> > is. Encoding this knowledge in chipset lists duplicates platform policy and
> > cannot survive a virtualized topology.
> >
> > Define HMAT Type 3 as a firmware contract for directional Generic Port P2P
> > paths, including separate ordered and Unordered I/O applicability. This
> > gives platform software a standard way to distinguish unsupported,
> > conditional, and usable paths. The definition follows a proposed ACPI ECN.
> >
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  include/acpi/actbl1.h | 27 ++++++++++++++++++++++++++-
> >  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> As per Documentation/driver-api/acpi/linuxized-acpica.rst, please
> submit a pull request with this change to the upstream ACPICA project
> on GitHub.  The Linux patch will become applicable when there is a
> corresponding commit upstream.

Sure, we will. However, at this stage, we are looking for
feedback on the idea.

Thanks.
