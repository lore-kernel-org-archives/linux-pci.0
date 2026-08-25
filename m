Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4114023ED6A;
	Tue, 25 Aug 2026 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787625817; cv=none; b=sFwTExqLL2zzk9VXQcoDTbhUjbqbGMEE8ZB9gXrZw/nL+22Ia0QyCOwrdLoAp4Fgwzst+thEg/IJtb6UpI4tp/FMSV1x+AS24pJuPLeDDz6oinNb+QdZ7zkHFV8NUyVVWmWUX0duYohrqRaqzbed3gKyoTNBzc0FBJg1tXTKLyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787625817; c=relaxed/simple;
	bh=pPhOfrChOhOwLq23YH+Ik+4jYTMVXn1WGB343qq5WXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fzfvzn0iFY8vXLlrbckrH7c0qsB2y10z60nVFH+cerehpOM3be79tFzU96qmlonNvokMQk9/1520xfpC5d6b3mD3DjK0S6DUdSzxG6CYtREMTW4rehSNzi0hCfDopKglo8tBEipurBYQ9omMUu5tdWueUihtZe7B2jMX+DF0mmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWAzDFeZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWAzDFeZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49661F000E9;
	Tue, 25 Aug 2026 02:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787625815;
	bh=pPhOfrChOhOwLq23YH+Ik+4jYTMVXn1WGB343qq5WXk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWAzDFeZP38RuZPBGqPgTeV9Lhp6l7+2YPYsogbiNE1BZKi6jlsIqXBWpAEoFDrNa
	 6mtJc1spEJa/Gc+L28D+f/SNGfcb3lpwgXY2OsI21yXXQbTFuxTQzgFTDiag1GR9EQ
	 VgrSPOBSIYB1J51qAbxavr2P5wUUwCfcQ5YQi5LBlvHQPrYhHSVnZ6ujOmPckabBbO
	 8sRSI8YNjVe7txcJOqX41Ybl2bD4h6Bo2W916C1oYMfnxrKRLE4q/h5Smgxc3Vexg0
	 Pna97sw7EeiZRvW97CPs16xLVsxoe8V4hnSB4GCTZa5buoo1dDJN5Y+t+q3+MHYTU7
	 QZELmNB5y4vJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] cxl/core: Restore the HDM decoders below DPort
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825022628.3651434-6-fabio.m.de.francesco@linux.intel.com>
References: <20260825022628.3651434-1-fabio.m.de.francesco@linux.intel.com>
 <20260825022628.3651434-6-fabio.m.de.francesco@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 02:43:35 +0000
Message-Id: <20260825024335.A49661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Lockless iteration of `port->endpoints` using `xa_for_each` in `cx=
l_port_recommit_decoders()` lacks protection from concurrent endpoint remov=
al, leading to Use-After-Free.
- [Low] Unused local variable 'dport' whose address is passed to a function=
 but never read.

Pre-existing issues:
- [High] Returning cxl_dport from find_cxl_port() leads to use-after-free b=
ecause its lifecycle is managed by devres and is not tied to the port's ref=
erence count.
--

--- Patch [5]: [PATCH v2 05/13] cxl/core: Restore the HDM decoders below DP=
ort ---
Due to system constraints regarding recitation of copyrighted or proprietary
material, this review is provided as a free-form summary without direct
inline quotes of the patch code.

commit c3d66df5869718f0ad0a7763a605cb85c574d23c
Author: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>

cxl/core: Restore the HDM decoders below DPort

This commit adds cxl_sbr_recommit_decoders() to restore HDM decoder settings
for CXL components below a Downstream Port after a Secondary Bus Reset. It
reads the endpoint set and switch decoder target lists while holding the
cxl_rwsem.region lock. It also drops the static declaration of find_cxl_por=
t()
so it can be used outside of port.c.

[Severity: Low]
In drivers/cxl/core/dport_sbr.c, inside cxl_sbr_recommit_decoders(), the lo=
cal
variable dport is declared and its address is passed to find_cxl_port(). Si=
nce
dport is never read or accessed again after this call, is this variable
necessary, or can we pass NULL if the downstream port is not needed?

[Severity: High]
In drivers/cxl/core/hdm.c, cxl_port_recommit_decoders() uses xa_for_each() =
to
iterate over port->endpoints. Does this lack protection from concurrent
endpoint removal?

The lock held during this walk is cxl_rwsem.region. Concurrently, a sysfs
unbind could trigger cxl_detach_ep(), which holds device_lock(&port->dev)
and frees the port_ep structure via kfree(). Because xa_for_each() internal=
ly
acquires and drops the RCU read lock per iteration, the port_ep pointer can
become dangling before the loop body dereferences port_ep->ep, resulting in=
 a
use-after-free.

[Severity: High]
In drivers/cxl/core/port.c, find_cxl_port() populates and returns the dport
pointer via the cxl_find_port_ctx struct.

This is a pre-existing issue, but does retrieving the cxl_dport pointer this
way lead to a potential use-after-free? The cxl_dport memory is managed by
devres and is freed when the port's host device unbinds. It is not pinned by
the returned cxl_port's reference count. If a caller holds the port referen=
ce
but the port's host unbinds concurrently, accessing the dport pointer will
result in a use-after-free. Exporting find_cxl_port() to the rest of the
subsystem expands this vulnerable API surface.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825022628.3651=
434-1-fabio.m.de.francesco@linux.intel.com?part=3D5
