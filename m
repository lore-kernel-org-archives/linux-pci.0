Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B42E739D
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786718886; cv=none; b=F5lxuVrsH1km4+4y2x7qYIJaJ0BfuZKJbalh+XmP2wtFPr6azUcSui6VPVRwCXJDqA1oy/TquEkIN/sMNTqwuvGQI1AeR7UDbTJ7I5Um7r3UcfRmQiXN3ZPccID4bdMjpHyuigYTDI4cNcXMiMOWKX8WvXuzytcJt0uPX/08O3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786718886; c=relaxed/simple;
	bh=Dl/mjjInEbhcKf8Z1ru6BEkouVnQURpVEDBUKpFpC1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ix91Z7uhnK1sNx/6IXq3mVY9vfwJGXD1TOrh3QXjZ2hTw2uzMrnpWm7SOPwu62YNcVZSX+z2Zs8VKw+HkfbXY3eU0y7gErLJMFJVdliW2klFFLQfu0g6d+kspYf+AA8Mo/CQTHvzk0U09X8j312KdAmvkf7UT6aAbE6Mzh9cgTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HvzhKQHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HvzhKQHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41911F000E9;
	Fri, 14 Aug 2026 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786718885;
	bh=Jg1bKQctW2ehEQ5UdxyPMSS9hbSDCIBfRbdClP/DtmY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HvzhKQHhtlH3DiLWwYKw2G6u+4nZDCZpX8e91CRIKSB/UrrKShuSUVIcv8H2256AW
	 LlAI+ujJMPNcmmCi8+LQkyNSEmMs/GxvaB43F+W/FndVdbufmJLC7oi0LJDoNfYs2A
	 IfhG1LdVvR5VOe27gGQk9ZQ/ie1yjIITPy70ik5eUb2rSJz2DyHzqDHMDuQxCckDAE
	 C3lZUCESzFE0X4mdPh4OAQpVPK2obaOvMvB/mpkihEyYG+f3dffTXVyWTWOqfSeWT1
	 0r3LNkTaZ2UAXnkvjPaKiTUc1lEuZwEaLwOSfNK/tSQJWfwP8FXPVTqcbG/qkHqLfs
	 xem5gHCXu4ibA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] nfs: migrate direct I/O to
 iov_iter_extract_pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: "Anna Schumaker" <anna@kernel.org>, "Jeff Layton" <jlayton@kernel.org>, linux-pci@vger.kernel.org, "Chuck
 Lever" <cel@kernel.org>
In-Reply-To: <20260814143255.861084-5-praan@google.com>
References: <20260814143255.861084-1-praan@google.com>
 <20260814143255.861084-5-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:48:04 +0000
Message-Id: <20260814144804.D41911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If request creation or insertion fails mid-chunk, the iterator is =
not reverted for the remaining un-scheduled bytes, leading to iterator desy=
nc.
- [High] If `iov_iter_extract_pages` returns 0, the scheduling loops will s=
pin infinitely without making progress.
--

--- Patch [4]: [PATCH v6 4/5] nfs: migrate direct I/O to iov_iter_extract_p=
ages ---
commit 5228f408a5f9a33be680decc8231db65a3427585
Author: Pranjal Shrivastava <praan@google.com>

nfs: migrate direct I/O to iov_iter_extract_pages
   =20
Migrate the NFS Direct I/O path away from the legacy
iov_iter_get_pages_alloc2() API to the modern iov_iter_extract_pages API.
The transition aligns NFS with the modern VFS extraction model and serves
as a preparatory step for supporting requirements such as page pinning
via GUP for DMA.

> diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
> index 96995736fac2a..a1479fbf4f9e1 100644
> --- a/fs/nfs/direct.c
> +++ b/fs/nfs/direct.c
[ ... ]
> @@ -348,16 +348,17 @@ static ssize_t nfs_direct_read_schedule_iovec(struc=
t nfs_direct_req *dreq,
>  	inode_dio_begin(inode);
> =20
>  	while (iov_iter_count(iter)) {
> -		struct page **pagevec;
> +		struct page **pagevec =3D NULL;
>  		size_t bytes;
>  		size_t pgbase;
>  		unsigned npages, i;
> +		bool pinned =3D iov_iter_extract_will_pin(iter);
> =20
> -		result =3D iov_iter_get_pages_alloc2(iter, &pagevec,
> -						  rsize, &pgbase);
> +		result =3D iov_iter_extract_pages(iter, &pagevec,
> +						rsize, ~0U, 0, &pgbase);
>  		if (result < 0)
>  			break;

[Severity: High]
This is a pre-existing issue, but if iov_iter_extract_pages() returns 0,
will this loop spin indefinitely?

The outer loop in nfs_direct_read_schedule_iovec() relies on
iov_iter_count(iter) > 0 to terminate. If iov_iter_extract_pages() returns
0 (which can happen if zero pages are pinned), the result < 0 check won't
catch it.

This leaves the iterator unadvanced and bytes =3D 0, causing the loop to
repeat indefinitely and potentially leading to a kernel hang.

Should the check be updated to if (result <=3D 0)?

> -=09
> +
>  		bytes =3D result;
>  		npages =3D (result + pgbase + PAGE_SIZE - 1) / PAGE_SIZE;
>  		for (i =3D 0; i < npages; i++) {
> @@ -371,7 +366,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct =
nfs_direct_req *dreq,
>  			unsigned int req_len =3D min_t(size_t, bytes, PAGE_SIZE - pgbase);
>  			/* XXX do we need to do the eof zeroing found in async_filler? */
>  			req =3D nfs_page_create_from_page(dreq->ctx, pagevec[i],
> -							false, pgbase, pos,
> +							pinned, pgbase, pos,
>  							req_len);
>  			if (IS_ERR(req)) {
>  				result =3D PTR_ERR(req);
> @@ -380,6 +375,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct =
nfs_direct_req *dreq,
>  			if (!nfs_pageio_add_request(&desc, req)) {
>  				result =3D desc.pg_error;
>  				nfs_release_request(req);
> +				i++;
>  				break;
>  			}

[Severity: High]
This is a pre-existing issue, but does this early break cause the iterator
to become desynchronized?

iov_iter_extract_pages() advances the iterator by the total extracted bytes.
If the inner loop breaks early here (e.g. because nfs_pageio_add_request()
fails), the remaining unprocessed bytes in the chunk are skipped, but the
iterator is never reverted for those skipped bytes.

The caller calculates the revert amount based on successfully processed
bytes, so the iterator remains incorrectly advanced. If the VFS retries the
remaining data, it might resume from the wrong offset and silently skip
data.

Does this path need to call iov_iter_revert() for the unprocessed bytes?

[ ... ]
> @@ -888,13 +888,14 @@ static ssize_t nfs_direct_write_schedule_iovec(stru=
ct nfs_direct_req *dreq,
> =20
>  	NFS_I(inode)->write_io +=3D iov_iter_count(iter);
>  	while (iov_iter_count(iter)) {
> -		struct page **pagevec;
> +		struct page **pagevec =3D NULL;
>  		size_t bytes;
>  		size_t pgbase;
>  		unsigned npages, i;
> +		bool pinned =3D iov_iter_extract_will_pin(iter);
> =20
> -		result =3D iov_iter_get_pages_alloc2(iter, &pagevec,
> -						  wsize, &pgbase);
> +		result =3D iov_iter_extract_pages(iter, &pagevec,
> +						wsize, ~0U, 0, &pgbase);
>  		if (result < 0)
>  			break;

[Severity: High]
This isn't a bug introduced by this patch, but similar to the read path,
if iov_iter_extract_pages() returns 0 here, will it result in an infinite
loop in nfs_direct_write_schedule_iovec()?

[ ... ]
> @@ -938,6 +938,7 @@ static ssize_t nfs_direct_write_schedule_iovec(struct=
 nfs_direct_req *dreq,
>  			if (desc.pg_error < 0 && desc.pg_error !=3D -EAGAIN) {
>  				result =3D desc.pg_error;
>  				nfs_unlock_and_release_request(req);
> +				i++;
>  				break;
>  			}

[Severity: High]
This is a pre-existing issue, but this write path seems to have the same
iterator advancement leak as the read path when breaking early on hard
errors. Should it also revert the iterator for the unprocessed bytes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814143255.8610=
84-1-praan@google.com?part=3D4
