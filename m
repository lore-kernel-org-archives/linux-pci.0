Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FDD35DA75
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289304; cv=none; b=HhRmkqjslDrdHS3zbrjvBraDAEkdyXYCuh5rR3QA61mu15mce92fnNkrb3fIkgTED4+CveU1KNhoatz+bBG/4GJmQ00+VpEJtNMI6gheTZRWYcBNZmpCtG7F6ZgbL5mUEFT1m/v6pSk680oHdiFfKXG+0BxK2QKH2NrasWTd/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289304; c=relaxed/simple;
	bh=Qg/7tdof3sMy0/BDU5MoZNrY4BBXMl80pLWFAxaP11w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5BLy3HtlYlx7kSKEH7NBzJ90Nmk/+x+CDpWQJJxD1d/enu79WazzLRc5JUGnCq3gTow2DNCnIup1bAG7JXQSYRr2t5Lm0NeD4KAdjjYHRiVg3ZPLgcjD69S+7PpobvMkLXe+RwaK2QcxXpH6m/v+qnqWdvf9cpxroDNFr0Argg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+yPoJ5k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+yPoJ5k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F7A1F00A3A;
	Sun,  5 Jul 2026 22:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289303;
	bh=PM1Hklno7Rvmr5uDzcHzI16I2zX0GOIa+Tw/d3KlFNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+yPoJ5k9ZOvVcZ7rXlN1f5zCFyQslVmZSQcXd1g3l9pzDGNBVischRCInbQJHy48
	 wlCer7lr02dDxi86nkm00y26Xo+sKJRcOqZTcbRdGnlGFIFk9Aux/JOz2T24NippFn
	 48yOL+5jgR37ozg8L1RnXccv9d/xwfc1spFAG/JjH4bn4um5znrbJlL2m+22c0BjGS
	 eYwoh2tYnyLbKyVf2rWeDxR+q3f+DZueNqd8wPa4dwxt7dLJo243qqm6W7W2N1UIss
	 9yV1w3boplFIH8DkkTBwYeNQ6LA66Drad3tNnxMJ2RVDRnx1W5WX8fhR56kIdx+DmE
	 fxFbv/BCGi+bg==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id A060DF40069;
	Sun,  5 Jul 2026 18:08:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Sun, 05 Jul 2026 18:08:22 -0400
X-ME-Sender: <xms:1tVKagAJgGm-NMpRtn0O9UHDGPcIDK5NnoNYqxL1fDE4PuwcgkEVVw>
    <xme:1tVKai-LO1FzcmaaBms97rznwdepI-qUIsB7O6UwqVQzvAh4-jTiQ9Ct_ikFtWuqi
    TuOUYpYZkHXc6JHzc8r-UYdZdzHGkj7rgFIEiLU1snYpbUQU0vHb5Y>
X-ME-Received: <xmr:1tVKakR5we_r5qzFWgO0tQ1Lzu9jH7dZVsVtPWtz7nvaV9FaKDxw-Q_ppN9jZpN0h3G32gb_X7iPiKPNwhlFszU82w5s1FshsaY>
X-ME-Proxy-Cause: dmFkZTE+LoDvVfWLk8siPms9Q0CDAKMOC0XGzUOUm5xAOc/dqOWu4jphr8Fkmazfwsil3W
    FnzkHEnXtGLnYYAnMpC4usNxBHPmyHXfhoCCkF5SzibkAd4xL0CORiZ4886ESdT5ktkUTo
    9gKE3QpXz/nTHnsAhlIg32u6J1mC9DKCg7Q2XdUSkdQsep4jEtzdl9BSVfrdYFRuoiwrQo
    GIuU61Dv5i+gvN3D9tEbzAqR+0wpq+yB3jA+koFv8ae0EocFc2LcB+vHW7YaAu38th9Q7J
    rMlFM7YDu76bAoA9tFAMVlTHpPujDo1aQrIOL3hDDjcSsS4Lxie1A6soMqA87KibXE9UeG
    JmASRTIEGBc+vvdYrWKIxtRJI1soBoMWGeXc4wHHzHsrkQ813fy7q3+fWLioykw2Y65V3e
    /bMwSJy46KA2p1lilr5lE0bHDYSeeQJhw8zYYelJuCGKBouZ1mQQM+48TL5nutpD3QttLi
    6goI/oCBpxO1QrCDQdWGFWQjML093JLmxMxEVp233lMduIYDYASDjk710HBC6wfr2TcYFi
    4CMvz1Fr7Q1vAMJxD0pwPRj5EqR1M4zhoHkxq6WQCakGJ1uUwYz6BFG9NeijMOs/QAQxbg
    nn5WBqTontIl/iriytE8VQmIwNBsK2FzIYRjCE1UywbHZZRQgtydBp0DEECQ
X-ME-Proxy: <xmx:1tVKauWgzyJPlDjDL_G0QhEYKVrtnhpEqClMnoscn5zcnhPsAAdUgQ>
    <xmx:1tVKamR4t7mrMatgmqP0RjeYXvzlQnV3vBsDr2lfdlssorjbTQXCdQ>
    <xmx:1tVKau0b7c0jhWCPZCd6fLd-NgZ6K-u2qpR-4Jd88X5EoTF7ZqvzQA>
    <xmx:1tVKaueppVUCcY50E8-EPnr9RlaqAl6H4CCiRywkRtyapLv9ngwMgQ>
    <xmx:1tVKauNYJRqyf9-cYVEYgoHnafawOttpknGjI6Jn0ncDSlBye1oatgBm>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:22 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Lukas Wunner <lukas@wunner.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>
Subject: [PATCH 01/15] netlink: specs: Introduce multi-message blobs for SPDM
Date: Sun,  5 Jul 2026 15:08:05 -0700
Message-ID: <20260705220819.2472765-2-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPDM, Security Protocol and Data Model, underpins PCI device security
and other use cases. It defines objects that allow for verification of
device identity and configuration. These objects can be large in size 16MB.
Netlink is otherwise suitable to define the operations, with optional
parameters, and notifications for working with these objects. For example,
operations like "regenerate evidence with nonce", "mark evidence
validated", and "broadcast evidence / security state change events".

A netlink 'blob' is introduced as a way to teach YNL that one instance of a
attribute may span multiple messages. It enables netlink to convey all the
data needed for verification and manipulation of SPDM transported evidence.

The schema change to allows YNL to infer that an attribute may span
multiple messages and interrogate its length to preallocate an
appropriately sized receive buffer.

The design direction to extend the netlink schema for a "multi-message
object receive" case was the result of this discussion [1].

Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>
Link: http://lore.kernel.org/20260318170014.6650d2bf@kernel.org [1]
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 Documentation/netlink/genetlink-legacy.yaml | 6 ++++++
 Documentation/netlink/genetlink.yaml        | 7 +++++++
 Documentation/netlink/netlink-raw.yaml      | 7 +++++++
 3 files changed, 20 insertions(+)

diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index f9c44747729a..fff9d7b76dbc 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -239,6 +239,12 @@ properties:
                 enum: [ little-endian, big-endian ]
               multi-attr:
                 type: boolean
+              bloblen:
+                description: |
+                  Marks this attribute as a variable-length blob that may be split across
+                  multiple messages. The value names a separate scalar attribute that carries
+                  the total blob length, and which is sent ahead of the blob data so a consumer
+                  can preallocate the full payload.
               nested-attributes:
                 description: Name of the space (sub-space) used inside the attribute.
                 type: string
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index d3f3f3399ddf..4caee7d55303 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -153,6 +153,13 @@ properties:
                 enum: [ little-endian, big-endian ]
               multi-attr:
                 type: boolean
+              bloblen:
+                description: |
+                  Marks this attribute as a variable-length blob that may be split across
+                  multiple messages. The value names a separate scalar attribute that carries
+                  the total blob length, and which is sent ahead of the blob data so a consumer
+                  can preallocate the full payload.
+                type: string
               nested-attributes:
                 description: Name of the space (sub-space) used inside the attribute.
                 type: string
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 4c436b59a34b..dd85f0c56631 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -263,6 +263,13 @@ properties:
                 enum: [ little-endian, big-endian ]
               multi-attr:
                 type: boolean
+              bloblen:
+                description: |
+                  Marks this attribute as a variable-length blob that may be split across
+                  multiple messages. The value names a separate scalar attribute that carries
+                  the total blob length, and which is sent ahead of the blob data so a consumer
+                  can preallocate the full payload.
+                type: string
               nested-attributes:
                 description: Name of the space (sub-space) used inside the attribute.
                 type: string
-- 
2.54.0

