Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F22E7BD9;
	Sat,  5 Sep 2026 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616381; cv=none; b=N4Xi7tdCeJZoJvAqOW9q5RWFEEX2yAwBUhj4dKsWWJIkzxtXF3FB6BnwaqhymeSRRpq8GeKV0NPGkkcC5D+RfuDuKP5XGy46Nvf3jk04oV5mltt+vXmMXSsAGjT2xnwY/KOH1xVH9+A+lZKmNPZlqHkiwl42K8D0iZdNVZ+lD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616381; c=relaxed/simple;
	bh=ICpjIlt9wAUbEsQCN+Buysn5yk3y3EIM/dSswA0ArwI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pglEhtCApT28/CR7CIjU52w+N3iDmyohwq4nrjC2975alwlXhzgVtryKOzFyZa07LY+NFbi63EHkrQoMSvMnNyjNBOwvbtXm9xQK0gOPFOK1DXaa8MKCin+ZDMAI+Ov+7Jprqd7i/deOBYsith7kJpuJhhQhtpEnYwtpTVioS7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUmaAU55; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUmaAU55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CDD1F00A3D;
	Sat,  5 Sep 2026 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788616379;
	bh=zZjkzm2By1Q4yFFKjOhJvW+etUb+Y9b4tSPUDq10vbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUmaAU55VuT2qbHC1zTazzhdg5XhCwvCqxbaZgCRYSZCt3yXpC9nnru6COAiiX+X8
	 BntySXE468xq6kvptwpocBUK3I9M09x70KF76nCWSq1JqrBRvjjqWwjxOwvN8Na1//
	 VAdUZnInyf+F1fAdHDSU9j/F3O/3KAfWzGKLP34ZXAyY7XNJt/018T+r7zGm6zweNP
	 1uMM70w8RJAGOQ59ylzehs6cZckDdzoVpLh38BLdKGBFZKZW3lKajGWGqzZMkHQFYg
	 qYGKNXcLiqpiVRbEZ2cps/5EqORnGKLLsZp0g9HNMNqCHtDeajkgCiQlOZLu+1LWUA
	 kjM9cP98QD/gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10] media: dvb-core: extirpate defective and unsafe ULE
 debug block
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, linux-input@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org
In-Reply-To: <20260905132812.8521-1-breno3011alves@gmail.com>
References: <20260905132812.8521-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:52:58 +0000
Message-Id: <20260905135259.64CDD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:

New issues:
- [Low] Mismatch between function definition and function call resulting in=
 a compile error.

Pre-existing issues:
- [Critical] Missing payload length check for the MAC address when the ULE =
D-bit is 0 leads to an out-of-bounds read and an integer underflow of skb->=
len.
- [High] Error paths in `dvb_net_add_if()` fail to clear `dvbnet->state`, l=
eading to a NULL pointer dereference on teardown.
- [High] Workqueues are flushed before `unregister_netdev()`, allowing conc=
urrent re-arming and subsequent Use-After-Free.
- [High] Dangling `net_device` and Use-After-Free on hardware hot-unplug if=
 the interface is UP.
- [High] Concurrent execution of interface removal causes a Double Free of =
`net_device`.
- [High] Out-of-bounds read in ULE extension header parsing due to missing =
boundary checks.
- [Medium] The multicast list workqueue starts the demux feed without check=
ing if the network interface is running, leading to packet processing on an=
 offline interface.
--

commit a436ecc632e24cc55cee7118d76ed42b70d862e1
Author: Breno Rodrigues Alves <breno3011alves@gmail.com>

media: dvb-core: extirpate defective and unsafe ULE debug block

Completely purge the unmaintained DVB_ULE_DEBUG code block from
dvb_net.c and its Kconfig definition to eliminate severe lockless race
conditions and clean up the unused function signature parameter.

> diff --git a/drivers/media/dvb-core/dvb_net.c b/drivers/media/dvb-core/dv=
b_net.c
> index a2159b2bc1766..5060b8866de8a 100644
> --- a/drivers/media/dvb-core/dvb_net.c
> +++ b/drivers/media/dvb-core/dvb_net.c
[ ... ]
> @@ -843,7 +803,7 @@ static void dvb_net_ule(struct net_device *dev, const=
 u8 *buf, size_t buf_len)
>  				       *(tail - 2) << 8 |
>  				       *(tail - 1);
> =20
> -			dvb_net_ule_check_crc(&h, iov, ule_crc, expected_crc);
> +			dvb_net_ule_check_crc(&h, ule_crc, expected_crc);

[Severity: Low]
Does this change cause a compilation error? The patch updates the call site
to pass 3 arguments, but it looks like the function definition of
dvb_net_ule_check_crc() was not updated and still expects 4 arguments:

static void dvb_net_ule_check_crc(struct dvb_net_ule_handle *h,
                                  struct kvec iov[3],
                                  u32 ule_crc, u32 expected_crc)

>  			/* Prepare for next SNDU. */
>  			reset_ule(h.priv);

[Severity: High]
This is a pre-existing issue, but can the error paths in dvb_net_add_if()
cause a null pointer dereference on teardown?

dvb_net_add_if() calls get_if() to reserve a slot by setting
dvbnet->state[if_num] =3D 1, but if alloc_netdev() fails:

	net =3D alloc_netdev(sizeof(struct dvb_net_priv), "dvb",
			   NET_NAME_UNKNOWN, dvb_net_setup);
	if (!net)
		return -ENOMEM;

It returns an error without resetting dvbnet->state back to 0, leaving
dvbnet->device[if_num] as null.

Later, when dvb_net_release() or the remove interface ioctl cleans up, it
iterates over active slots and calls dvb_net_remove_if():

	struct net_device *net =3D dvbnet->device[num];
	struct dvb_net_priv *priv;

	if (!dvbnet->state[num])
		return -EINVAL;
	priv =3D netdev_priv(net);
	if (priv->in_use)

Is it possible for netdev_priv(net) to blindly dereference this null pointer
and cause an oops?

[Severity: High]
This is a pre-existing issue, but it looks like flushing workqueues before
unregister_netdev() allows concurrent re-arming and a subsequent
use-after-free.

In dvb_net_remove_if():

	flush_work(&priv->set_multicast_list_wq);
	flush_work(&priv->restart_net_feed_wq);
	pr_info("removed network interface %s\n", net->name);
	unregister_netdev(net);
	dvbnet->state[num]=3D0;
	dvbnet->device[num] =3D NULL;
	free_netdev(net);

The workqueues are flushed before unregister_netdev() without holding the
rtnl lock. Concurrently, an interface up command could take the rtnl lock,
mark the interface up, and schedule a workqueue after the flush completes.

When unregister_netdev() executes, it takes the rtnl lock and brings the
interface down, but does not cancel the newly queued work. After it returns,
free_netdev(net) is called.

Could this allow the workqueue to execute wq_set_multicast_list() on freed
memory?

[Severity: High]
This is a pre-existing issue, but could hardware hot-unplug lead to a
dangling net_device and use-after-free if the interface is administratively
up?

When dvb_net_remove_if() is called, it returns early if the interface is up:

	priv =3D netdev_priv(net);
	if (priv->in_use)
		return -EBUSY;

However, dvb_net_release() ignores this return value:

	for (i=3D0; i<DVB_NET_DEVICES_MAX; i++) {
		if (!dvbnet->state[i])
			continue;
		dvb_net_remove_if(dvbnet, i);
	}

This ignores the busy status and continues teardown, freeing the backend dvb
adapter structures.

Does the net_device remain actively registered in the network stack, causing
a use-after-free if subsequent packet reception or state changes dereference
the freed pointers?

[Severity: High]
This is a pre-existing issue, but it appears concurrent execution of
interface removal causes a double free of net_device.

In dvb_net_remove_if(), the validation check is unprotected:

	if (!dvbnet->state[num])
		return -EINVAL;

While the remove interface ioctl path is protected by a mutex,
dvb_net_release() invokes removal concurrently without holding it:

		dvb_net_remove_if(dvbnet, i);

Could both threads validate dvbnet->state[num] =3D=3D 1 simultaneously and
proceed to sequentially call unregister_netdev() and free_netdev() on the
exact same net_device pointer?

[Severity: Medium]
This is a pre-existing issue, but is it safe for wq_set_multicast_list() to
force the data feed on without checking if the interface is running?

	netif_addr_unlock_bh(dev);
	dvb_net_feed_start(dev);

If the interface is administratively brought down, dev_close() flushes
multicast filters and schedules this workqueue.

Does the workqueue execute after the interface is functionally down and
unconditionally call dvb_net_feed_start(dev), which could bombard the
offline interface with packets?

[Severity: High]
This is a pre-existing issue, but is there an out-of-bounds read in
handle_one_ule_extension() due to missing boundary checks?

		ext_len =3D hlen << 1;
		/* Process the optional extension header according to its type. */
		if (ule_optional_ext_handlers[htype])
			(void)ule_optional_ext_handlers[htype]( p );
		p->ule_next_hdr +=3D ext_len;
		p->ule_sndu_type =3D ntohs( *(__be16 *)(p->ule_next_hdr-2) );

Is the pointer advanced by an attacker-controlled length and dereferenced to
read the next header type without verifying that the new pointer remains
within the boundaries of the received skb payload?

[Severity: Critical]
This is a pre-existing issue, but can a missing payload length check for the
mac address when the ule d-bit is 0 lead to an out-of-bounds read and an
integer underflow of skb->len?

dvb_net_ule_new_payload() validates length using:

		if (h->priv->ule_sndu_len < 5) {

This fails to account for packets where the d-bit is 0, which mandate a
6-byte mac address. If a crafted packet with ule_sndu_len =3D 5 and d-bit =
=3D 0
arrives, dvb_net_ule_check_crc() executes:

	/* CRC32 was OK, so remove it from skb. */
	h->priv->ule_skb->tail -=3D 4;
	h->priv->ule_skb->len -=3D 4;

	if (!h->priv->ule_dbit) {
		...
		skb_copy_from_linear_data(h->priv->ule_skb, dest_addr,
					  ETH_ALEN);
		skb_pull(h->priv->ule_skb, ETH_ALEN);
	}

If the skb length is 3, unconditional subtraction of 4 causes an integer
underflow.

Could skb_copy_from_linear_data() then copy 6 bytes, leaking uninitialized
kernel heap into the destination mac address?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905132812.8521=
-1-breno3011alves@gmail.com?part=3D1
