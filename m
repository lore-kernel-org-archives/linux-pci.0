Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F643FCC;
	Sat, 11 Jul 2026 01:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783734213; cv=none; b=rCA3xxVdEknrqibDMNUwsOYJU4J4bwuYCHT7wRlSDsBJKR/VY6obPxNmynHsyPFElXBvizDfv4PpZRNhPkzbrUr4cTA1QW1GNMbUcnf0zsg4cSG6on1OdjgQJsgnsIYpeOMm5d9IKMnl66mT9GwSKZZuwbxmRfRsLfnomJE3Dys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783734213; c=relaxed/simple;
	bh=S0g/haHOPSvzU2y79/QbSWXT5WgEKV6clUHehCK8cck=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G0THQoMOEhp+G2t9Rc/JunXs1atutQSccD07U1LYdRpzP2rPhpF/aYK7tM8JnsC2ceeTNA8arITZ3zIBC5pwnxQOOv+Wqaz0T6K0/b0YO5L3Qto1tvPSx3Oe13HhLIfrVea0EHJms5l0OkWJzEv0CjB0u//nOznox1siDuC6MI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PABJnd6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PABJnd6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B539E1F000E9;
	Sat, 11 Jul 2026 01:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783734212;
	bh=X5VqJXvLCLHTE8wks7JmS5ApvXkflB2plX8EZ0k1ucQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=PABJnd6y/ULiJpKMY60px+O/S9+yOYzq2Hu69zW1//dFwTbBMKKfhYY7EtAT+MpeA
	 zB2qF1wRC6yolnGIDImqJmiceYrsgvUA4QobkGALlqBxw66SY2RNn8ixWT1H7gfkzt
	 zBFlGmzxbtS1G9+FELJPm4Y77pguZtKKyOTN/oTASUmYIdj9hwwNSFVajRzw6oVEuL
	 Ht8IT6tr0p7t1WMePjJp5tQFm5XKUnvw1WPpoYnTH+Vp/jbI2YOR2D7Ogh1F+soPZx
	 hWNWfCHgRkfOJK3txTEObQuIxxHh5Urd25gLXFYKSXBrcVR6vjZOtnEZBsw0UxrDaZ
	 DC40K+RR4REQg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id DB08FF4021A;
	Fri, 10 Jul 2026 21:43:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 10 Jul 2026 21:43:30 -0400
X-ME-Sender: <xms:wp9RaptfVbaWOtDQE1hjlfEs8ywkPv8WS42paTF2XSnKkRrrHs1M_Q>
    <xme:wp9Rai6txPToY7cPmWX-RQbb2Afx-t59Rr6nc1WGBHO52kEOZGsK-384P-soi5rc_
    QEI7atlYGged36DPziQke-YR3lRECzw7H1bkB1Jj-yBGeTFb6_mNKJs>
X-ME-Received: <xmr:wp9RatcMxD7sKpt_Wt41-L6Oc-4xMLl6zMKfqWEL4YewHmVJq8dm3FkJdOzTY22PCFd9LEmI8r6Be-rWpMr9iZXAPpK7nnwjovU>
X-ME-Proxy-Cause: dmFkZTFor6KCyo27hPkhFs4Wfza4vspf65rywiY4HhUO8p1nY97ffFzkLdXTLoU0Pe9vIy
    09TNBCuf8Ef1NooJTEY2XP1+mY7cvpQV+9pX5j9vfx0jMLoKYbjhrQazS+j6z0JXXmrpGt
    kCve8w7TzzxeoI/mibuWrXl+uCCoZN3LE3m+U4pNSH5BLlvafHSCwAiaUW0occ6oqnipka
    aWybdAXNfHa23plUT0JThbn7ESMN9cI1MVzHs2ZJfRwcPpDqPa3N36dRRVRktfnRYmJgJp
    hM1jY0hUjwVbnwWXRhQ/OwsBSZCljAJJwlH5vVZf2aeLDJB9JCppMwXcEKC/jpH+VwZJdk
    OIpyH2emn0OREAvzj3jS0c3TONdIHntjIBtECIh6/BIy/OB3aMsYWmdofIu04CDuWyJtU4
    V45CmYyPEeWP4q17/Q7o11GW4W9juSPR5YXFrP48JiYFe7gm5tfvXHZSAMVViD0u2pIKBB
    iCnG6kBnW8B6xvEdnQXzR1w6fhZCmFLuiZF02qzlMidUJH/Z9m5QJJzFndyI5GgENCs+Ll
    agn4S009/z1d6KmhoemnCw2ApzphfTLmAsLPk75qitVrVi4tHe1aI68kJpxgv/LBWEh8gz
    xlDaBjoV24Iw6dyDdLuQDf/eN+SqC/dosr3Pv5G0Rz2f+h4Gzy/+lWUNhTYw
X-ME-Proxy: <xmx:wp9RanyIAp1wrP_V-elMX-tx4JMNDOaJZifh64Gp2EQqpM0KFLbcRg>
    <xmx:wp9Raq-9qe5X-xXUj08WzE4oBO-K3dCtSlbpAcjYaHMMCMuYi9oTsw>
    <xmx:wp9Ratz-ee5QaYVrrQ2LujQ9b6ifHSNngXqI-xeGCwDIDxD0Oasc1w>
    <xmx:wp9RaqoD2Tt-xe900HQSHU03SH8zRXKX4D-KJx9JugQ1ejvF8s7Kpw>
    <xmx:wp9RaurCaxrslMTytDSVbfl3ftYc4MygLZjOHieTw62JXeocKdOj9ZQY>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 21:43:30 -0400 (EDT)
Date: Fri, 10 Jul 2026 18:43:29 -0700
From: "Dan Williams (nvidia)" <djbw@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, 
 Dan Williams <djbw@kernel.org>
Cc: linux-coco@lists.linux.dev, 
 linux-pci@vger.kernel.org, 
 driver-core@lists.linux.dev, 
 ankita@nvidia.com, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Lukas Wunner <lukas@wunner.de>, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <6a519fc19172_253dc100e8@djbw-dev.notmuch>
In-Reply-To: <m2y0flbuoa.fsf@gmail.com>
References: <20260705220819.2472765-1-djbw@kernel.org>
 <20260705220819.2472765-2-djbw@kernel.org>
 <m2y0flbuoa.fsf@gmail.com>
Subject: Re: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for
 SPDM
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Donald Hunter wrote:
> Dan Williams <djbw@kernel.org> writes:
> 
> > The SPDM, Security Protocol and Data Model, underpins PCI device security
> > and other use cases. It defines objects that allow for verification of
> > device identity and configuration. These objects can be large in size 16MB.
> > Netlink is otherwise suitable to define the operations, with optional
> > parameters, and notifications for working with these objects. For example,
> > operations like "regenerate evidence with nonce", "mark evidence
> > validated", and "broadcast evidence / security state change events".
> >
> > A netlink 'blob' is introduced as a way to teach YNL that one instance of a
> > attribute may span multiple messages. It enables netlink to convey all the
> > data needed for verification and manipulation of SPDM transported evidence.
> >
> > The schema change to allows YNL to infer that an attribute may span
> 
> change to allows -> change allows

ack.

> > multiple messages and interrogate its length to preallocate an
> > appropriately sized receive buffer.
> >
> > The design direction to extend the netlink schema for a "multi-message
> > object receive" case was the result of this discussion [1].
> >
> > Cc: Alistair Francis <alistair.francis@wdc.com>
> > Cc: Lukas Wunner <lukas@wunner.de>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Donald Hunter <donald.hunter@gmail.com>
> > Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]
> > Signed-off-by: Dan Williams <djbw@kernel.org>
> > ---
> >  Documentation/netlink/genetlink-legacy.yaml | 6 ++++++
> >  Documentation/netlink/genetlink.yaml        | 7 +++++++
> >  Documentation/netlink/netlink-raw.yaml      | 7 +++++++
> 
> I suggest you drop the changes to genetlink-legacy and netlink-raw
> because I don't think we want to support the blob functionality for
> legacy families.

Done.

> Can you also update Documentation/userspace-api/netlink/specs.rst to
> describe the multi-attr / bloblen API behaviour.

Added:

@@ -239,6 +239,16 @@ Boolean property signifying that the attribute may be present multiple times.
 Allowing an attribute to repeat is the recommended way of implementing arrays
 (no extra nesting).
 
+bloblen (multi-message binary blob)
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+String property specified on a ``type: binary`` ``multi-attr: true``
+attribute to indicate that this single byte array may span multiple
+messages. The string names an attribute that indicates the final size of
+the blob when all messages are received. This differs from other ``type:
+binary`` ``multi-attr: true`` instances without bloblen where each
+message is an attribute boundary.
+
 byte-order
 ~~~~~~~~~~
