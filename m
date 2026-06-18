Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AD5363C57
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775746; cv=none; b=J6oHWUKpf6pGbn8ccCgP/Blb4scdvq8BYZHM/Ocw62jqGwaotUTR7ps3oZEZiuHqC7gQchy+7RszOZm1/z8YU1C6ZYMmOB2e1y+pKgHrBS3h8U4eTQyc4DD4LEXBOXbMgUTlklAtQLY693XlSAk9ZTvSk/JIvCHeghgPmh605vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775746; c=relaxed/simple;
	bh=o5N9Uehx92ArI2G0ER2Lt2BhIK0zyUiS0JMU3wOxp8s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BzaYPM7QASFHg14ewl47k+07fbcvXZcY5p8bqWfFGQ1+2vytDGgPqUrlx2hY4shaA4PwaP5EErrWiprx/Qp65yGzG+BGzG7OJDTlagqfdW3fecgZAExaviIw+3VQOHBL77B5fu1+kJEzA9IdKzi6DHR9TVxg5yq+o+UI31Ua6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3pmzJ+C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3pmzJ+C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B461F00A3A;
	Thu, 18 Jun 2026 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781775745;
	bh=Rc+Zpc1YoKalWNm3XAjgVT0O3z6OnDn/pVgUEHR2tK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3pmzJ+CBtw8fvHAWyWafLcyX8LsuCqL5vCcRHMEolN+Bv6QHyNyLTvdm/Vo6bwRQ
	 aOd0AiuphTTvw7qCCsJpQ+3Ax4IqtluMWK7vufnF9ScSQ0/O0/PIK18jlqIFeFiKrP
	 +MFSfJnirj2+Wio+I/UN11KKhIGr2P/RgktDoDPb7EHObrFPiaAuoro5t7lX4eVZCu
	 1/MQ22aBzaRxWaUSKLAwS/dadO5xxMrqocPjTKT+fQBEnd9BZwlL88RFB2zMfrIUgi
	 oZFaMRFQ7TzLAdi2P2JteFft96eFVYQtI1GV6oy/0/SbuZLApMtzIgsfE90fRdqGWa
	 VQXfBQcp+hA5A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] PCI: Sort resources by size as secondary key
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ding Hui" <dinghui@sangfor.com.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260618072536.28199-1-dinghui@sangfor.com.cn>
References: <20260618072536.28199-1-dinghui@sangfor.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 09:42:24 +0000
Message-Id: <20260618094224.F3B461F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete fix: `__assign_resources_sorted()` fails to maintain th=
e new size-based secondary sort key when bridge windows are dynamically res=
ized, breaking the sorting invariant.
--

commit b576a58abc2576977d567e69cb6a8b9e9d867d9b
Author: Ding Hui <dinghui@sangfor.com.cn>
Subject: PCI: Sort resources by size as secondary key

The commit updates pdev_sort_resources() to use resource size as a secondary
sorting key to reduce fragmentation. This resolves an issue on the BCM57414
NIC where function 1 failed to enable SR-IOV after remove and rescan due
to BAR allocation failures.

> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 4cf120ebe5adf..63f224f0c6bee 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -367,7 +367,8 @@ static void pdev_sort_resources(struct pci_dev *dev, =
struct list_head *head)
>  			align =3D pci_resource_alignment(dev_res->dev,
>  							 dev_res->res);
> =20
> -			if (r_align > align) {
> +			if (r_align > align ||
> +			    (r_align =3D=3D align && resource_size(r) > resource_size(dev_res=
->res))) {

[Severity: High]
Does this patch also need to update the re-sorting logic in
__assign_resources_sorted() to maintain the size-based secondary sort key?

When a bridge window requests additional size via realloc_head in
__assign_resources_sorted(), its size is increased:

drivers/pci/setup-bus.c:__assign_resources_sorted() {
    ...
    res->end +=3D addsize_res->add_size;
    ...
    if (addsize_res->min_align <=3D res->start)
        continue;

If the alignment does not increase, it skips re-sorting entirely, leaving t=
he
enlarged resource in its original position based on its older, smaller size.

If the alignment does increase, it is re-inserted into the sorted list, but
the loop only compares alignments:

    list_for_each_entry(dev_res2, head, list) {
        align =3D pci_resource_alignment(dev_res2->dev, dev_res2->res);
        if (addsize_res->min_align > align) {
            list_move_tail(&dev_res->list, &dev_res2->list);
            break;
        }
    }

This skips over elements with equal alignment, placing the newly enlarged
resource at the end of its alignment group and disregarding its size. Becau=
se
bridge windows are frequently dynamically resized, failing to sort them by
size when enlarged might place them behind smaller resources of the same
alignment, potentially re-introducing the fragmentation and allocation
failures this patch intends to solve.

>  				n =3D &dev_res->list;
>  				break;
>  			}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618072536.2819=
9-1-dinghui@sangfor.com.cn?part=3D1
