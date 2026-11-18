Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987664;
	b=SH5Emack8JP7D1D8S+5uBOZ1DpershIsku9Xxo7JmmokrGsYlSHVqCVmef1GXuMT/XFP
	 22iW7282pE1t7R6Eo29KuN77/M6TNstEhhwK2cq9l29PB2Tdtj6jIhgYFUYvz+hqNT1AS
	 XWKSGlVsd5NL7IHLfqk1l5O1RU5NKQkPm5uTgue6ZqVwdAl1IOYCAAmC/SJ+nGopCE5RC
	 X7jYq4DE0mtnvtKg00xrYuehDMOeHeQi3/plKlJq9D32vgldVZKvlCbph6GKa41s1s4lu
	 5bUSz0CWAqk+N37eqA+P5l2AWWmN4KgXeu48ZgYKYn4HoCr5QaZvdvD+eyPp9itQylw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987664;
	h=Received:DKIM-Signature:X-Mailer:From:To:Cc:Subject:In-Reply-To:
	 References:Date:Message-ID:MIME-Version:Content-Type;
	bh=Wt3MYwN2Oz3nGZVx57dbwOF2YI+O4Gttcy1klNT4PcU=;
	b=0KdC30q7VSwqdtFYrZdHw0Q9TQ9Pjzhw7uiWSrvWK/VVmljD+0rKrbMe88luFGWY3a28
	 FFcgJBfNo6nFXgmGFL1LC/lMJpdhx+ZSse9Jk14qhu8BWk+p+06QkSYKXQZPfCP/Dzbjt
	 8AQTCzAGxiUaOb2hf+OEougvIm/qhsb4auDxyx9xeYFG/0QMnKFPzLtUmLacG1wOI3qxG
	 PgBc3yGGvXc7gB6NMjhoYGUuHBPKA2bj9KwRxkMyfAkUfvMDQAZ9HgwUZ6tGjgk/TbZ2a
	 l5SQcdz3mycmQEwA40RM59JkyrX+vMFrAGSAQ62Xfmi/y860Cj0aEJohT1GF+wh9cBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1SNIVtz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186FE606A31C;
	Wed, 18 Nov 2026 07:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L1SNIVtz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ED41F000C4;
	Wed, 18 Nov 2026 07:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794987663;
	bh=Wt3MYwN2Oz3nGZVx57dbwOF2YI+O4Gttcy1klNT4PcU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=L1SNIVtz+QkrPeMz0cl59+bRSltLyp0H9uAnqOSdH6zffqYGgHxDzB7qrdKW6BGNd
	 h6b7N4aqfgw/ARZj0K1LykxbFEYFB8+g3G8bUmk6gdkrY2/BVPaQUopMeJpMqu/DF5
	 RimSLzTZrIQ58N+SPgCXg76Wl+4ZWLvyav6v+RTKmX/YqsDm5vRvZ9Em3tOFQYtTyP
	 K1gtbfp4BiPvrCdx44BjD0P2dSisdlvibjg1ofqYi6upJddHGpeqxbP8jA/HMDVRo+
	 DiJ+iyzQyzgeYeIHuNkyBvdraZFP+HhAoFmIR5QRzOs+XAZcETDFOaL1aiFUS9oNUg
	 d7UAKcrzANJwg==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/TSM: Move core code into its own directory
In-Reply-To: <20261116144237.GB2245175@nvidia.com>
References: <20261116075420.76205-1-aneesh.kumar@kernel.org>
 <20261116075420.76205-2-aneesh.kumar@kernel.org>
 <20261116130055.GB1850935@nvidia.com> <yq5ajymcyl2g.fsf@kernel.org>
 <20261116131959.GD1850935@nvidia.com> <yq5aecckyhdn.fsf@kernel.org>
 <20261116144237.GB2245175@nvidia.com>
Date: Wed, 18 Nov 2026 13:10:56 +0530
Message-ID: <yq5a1p8iy4c7.fsf@kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Jason Gunthorpe <jgg@nvidia.com> writes:

> On Mon, Nov 16, 2026 at 08:04:44PM +0530, Aneesh Kumar K.V wrote:
>> Jason Gunthorpe <jgg@nvidia.com> writes:
>> 
>> > On Mon, Nov 16, 2026 at 06:45:03PM +0530, Aneesh Kumar K.V wrote:
>> >
>> >> The complete CCA patch series adds the following files:
>> >> 
>> >> attestation.c  core.c  ctlv_attestation_pci_gen.c  ctlv_attestation_pci_gen.h  internal.h  Makefile  spdm.c
>> >
>> > Why would any of this go under drivers/pci ?
>> >
>> > The whole point here is to make an 'attestation subsystem', so that
>> > all belongs under
>> >
>> >   drivers/attestation/
>> >
>> 
>> So the attestation evidence would be fetched via drivers/coco/tsm/
>
> No.
>
> The tsm code causes an attestation driver to start, it doesn't do any
> attestation activties itself.
>
>> and stored by drivers/pci/tsm.c:pci_tsm_evidence.
>
> Why would we do that? Evidence is fetched, returned to userspace and
> discarded by the kernel.
>
>> I would expect drivers/attestation/ to provide helpers, like other
>> core kernel components, allowing different subsystems to register as
>> attestation backends, with PCI/TSM being one of them.
>
> I expect the thing in drivers/attestation/ to provide the full end to
> end driver. It calls the RMI/RSI/RHI's as directly as it can. Without
> spreading stuff around all over the place.
>
> Jason

I tried separating the CCA attestation driver from arm-cca-host in my
local tree. The main difficulty is coordinating locking and object
lifetimes with the existing PF0 and vDEVICE ownership rules.

PF0 owns the PDEV state and resources used for authentication and stream
activation. vDEVICE operations also depend on that PDEV, so a live
vDEVICE must keep PF0 and its resources alive. Restarting attestation
must not destroy a PDEV while active VDEVICEs still depend on it.

Placing the attestation backend in drivers/attestation/cca/ makes these
checks and locking requirements span two drivers. The attestation driver
calls PDEV_CREATE and PDEV_COMMUNICATE using the PDEV and communication
buffers owned by arm-cca-host. arm-cca-host uses the same PDEV to
connect streams and create vDEVICEs. The two drivers must therefore
coordinate access to these objects and their destruction.

My first attempt used pci_tsm_rwsem to serialize attestation operations.
That would require TSM callbacks for the attestation driver to acquire
and release the lock.

I also tried introducing an attestation_connection object with its own
mutex, reference count. Each vDEVICE then had to hold both its existing
PCI/TSM reference and a reference to this new object. The stream setup
still requires pci_tsm_rwsem, so this approach would also need callbacks
to acquire that lock before accepting evidence.

I am now considering implementing the CCA SPDM attestation ops directly
in arm-cca-host, similar to the viommu ops. The SPDM attestation ops
could then directly use PF0's PDEV, communication buffers, and existing
vDEVICE references. The same driver could prevent conflicting
PDEV/vDEVICE operations, and stop attestation commands before freeing
the associated resources.

-aneesh

