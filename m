Received: from mta0.migadu.com (out-44.mta0.migadu.com [91.218.175.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4FA33C18B
	for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 18:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790186961; cv=none; b=i62C8TUkE081fWQ+sVl9B0X2xdTnzsZLfEbwBCFLFVij/KjV+DTtdNsUHRsHVtmUVO8DqvS8KG+zAOebMN4mP51U24KuCXm6cmsfG9itp7iNbtK4yC9wKLsvOU0EXApYmAPDgjygi2l1ViNTZIiftxPLelO9UlZKXUWn/JRjs7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790186961; c=relaxed/simple;
	bh=hp4x+ywzXvafJkCdP8u0POUn9g1o98sJr1Tn/DdIbhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q81FAHjwlWWgp79D0acANBCe0so10q1KQttM5dPbRMqYJqrWqFEKqJuBO86uzZp8Eb3MyIe8b5B/1PiqHBWQnuNRinUkgHK7d90rsqqAsTscPGmVmWK7R7cbrdmaAv/DxsBepMupzVrYzcpmPLdU1h79sS4VYSriGvYSeRKH0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J0FXJKAu; arc=none smtp.client-ip=91.218.175.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J0FXJKAu"
X-Envelope-To: linux-pci@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=hp4x+ywzXvafJkCdP8u0POUn9g1o98sJr1Tn/DdIbhA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790186958; v=1; x=1790791758;
 b=J0FXJKAuHrsWFUPXCGKvyv4LUSoMNaLLs+cn5TRColBs8cnOJUoIyDJpFVvyOR3T72q/grhM
 dU9XsVlBj6jSxP5ga3TF8aZQTvrM2XNW9wnhWQVkx/J4fb4Utk7GbZ9TxaisYIDTmkELiyJjdtb
 8VRyDnj86HOf3qvDGJblkKsw=
X-Envelope-To: linux-pci@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 016718dd90252915;
	Wed, 23 Sep 2026 18:09:18 +0000
X-Mizu-Trace-ID: 016718dd90252915
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso983e87.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 11:09:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJ6sr84lbGwSBHJamrTKLvjMDg6zHuZWpcuJepcMSf0LCl2io9qdgf3OEK3SQNfdMUzMaHcgKrF9I=@vger.kernel.org
X-Gm-Message-State: AFuF++le9FazyWoH7H5HDJKA5kBKKEJKbBiHC2hVo0aBxaekw9SXmxIj
	FlugAZZhHbZELtZQU4D+T2Rkpy4R1ZvDGXQ2dRdZKGkZrC7J4AJJOdcnuTSw/3Vmz45yD8n48ta
	cMFf9RuBRT9mwyXs5hHsNK2IJ42SoT8XGkjjrRGYz
X-Received: by 2002:a05:6512:124d:b0:5b8:c230:1241 with SMTP id
 2adb3069b0e04-5b8dda17fd1mr39666e87.10.1790186953248; Wed, 23 Sep 2026
 11:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922210839.3765444-1-fuad.tabba@linux.dev> <20260923093433.00006cab@oss.qualcomm.com>
In-Reply-To: <20260923093433.00006cab@oss.qualcomm.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Wed, 23 Sep 2026 19:08:36 +0100
X-Gmail-Original-Message-ID: <CA+EHjTxcXmOk-kvQQtrT1mku=gmn4P4RdZXU2iAQhj+hn7Hjtg@mail.gmail.com>
X-Gm-Features: AclHuK_L10VanL22RC296bQJntGVijw67vDS6niPFFu4Q6Xzn6rsFFWvoeRnmqs
Message-ID: <CA+EHjTxcXmOk-kvQQtrT1mku=gmn4P4RdZXU2iAQhj+hn7Hjtg@mail.gmail.com>
Subject: Re: [PATCH] PCI: iproc: Use __free(device_node) in iproc_pcie_msi_enable()
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Rob Herring <robh@kernel.org>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, 
	Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Jonathan,

On Wed, 23 Sept 2026 at 17:34, Jonathan Cameron
<jonathan.cameron@oss.qualcomm.com> wrote:
[...]
> Hi Fuad,
>
> See the guidance notes in cleanup.h.   Linus has stated a couple
> of times that he really never wants to see = NULL pattern miles
> from where it is allocated.  Best you can do here is shift
> it down to immediately before of_msi_xlate(). It is fine to declare
> variables with destructors like this inline (i.e. not at top of function).
>
> Admittedly if the scope shown here had gone a few lines further this
> would look less bad!

Done: https://lore.kernel.org/all/20260923180703.3901185-1-fuad.tabba@linux.dev/

Cheers,
/fuad

>
>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 10 +++-------
> >  1 file changed, 3 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
> > index afb3aa38ac6bb..b4f4e6e1d4b41 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -1338,7 +1338,7 @@ static int iproc_pcie_msi_steer(struct iproc_pcie *pcie,
> >
> >  static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
> >  {
> > -     struct device_node *msi_node = NULL;
> > +     struct device_node *msi_node __free(device_node) = NULL;
> >       int ret;
> >
> >       /*
> > @@ -1357,18 +1357,14 @@ static int iproc_pcie_msi_enable(struct iproc_pcie *pcie)
> >       if (pcie->need_msi_steer) {
> >               ret = iproc_pcie_msi_steer(pcie, msi_node);
> >               if (ret)
> > -                     goto out_put_node;
> > +                     return ret;
> >       }
> >
> >       /*
> >        * If another MSI controller is being used, the call below should fail
> >        * but that is okay
> >        */
> > -     ret = iproc_msi_init(pcie, msi_node);
> > -
> > -out_put_node:
> > -     of_node_put(msi_node);
> > -     return ret;
> > +     return iproc_msi_init(pcie, msi_node);
> >  }
> >
> >  static void iproc_pcie_msi_disable(struct iproc_pcie *pcie)
> >
> > base-commit: fd73f4a6659897191fa0d40695fe370925dd3780
>
