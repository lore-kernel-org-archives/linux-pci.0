Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE0322A
	for <linux-pci@vger.kernel.org>; Wed,  8 Apr 2026 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687532; cv=pass; b=eCC/8tYR2+zWnL+TWoBfU7HoKpPJuR3sjHaT2lrtc3TBQO+hKXCK4Prln9eCMrWX6BFG8aHkv6rtBYVttfQMJ2Y6I22ZSX/qkT8Tt6+GIy/iTPIPim8aPu2Xjn3EQwWerH5I767GPQqj+d4s/XSX5ps4ls/KVavtRgtyE0mWUZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687532; c=relaxed/simple;
	bh=IZpPMH2uXRAuJm3GoI9DOO84aQStal6cbQJmXC/Si1Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bHLJljLK26tGSQxbKbcuhg3t43HTSPIkYikDCXheaVVATORV5WafX5PtkVp0OWOC1UeSzVE3zQ84Hz7lIVPFnpXEbKWK2YeZtc7DLarRfPa3QKizX8Tixr19Z7BuaoKq6TmkKuiwUoHHLSEgldMGuY5TYY+XsYp+n6qO+bQ8k44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com; spf=none smtp.mailfrom=jqluv.com; dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b=HaFHmRNT; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jqluv.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jqluv.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jqluv-com.20251104.gappssmtp.com header.i=@jqluv-com.20251104.gappssmtp.com header.b="HaFHmRNT"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-50697d6a69cso1607841cf.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2026 15:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775687530; cv=none;
        d=google.com; s=arc-20240605;
        b=J9obMpmzeeP0BIP4qbTFlDQeL/svcFeyTUSxDoMzZtQTJ+6+s03uOLDFPmZT9LuzUh
         x0GUC5YEJ9AujaK57jV6fq0Jzas0AJoBD9tKl8N3stBlKMxjs733rsCrt6UqgIUO7MCu
         7i3Daypg8wquLwRVPHJqazyBgSZSIQCWvshjeSfj3hD5nmDvCp8+ffL86nhlGRzN2AZW
         8OPrvnvCAiKgdf8vk+5mCC4lbwNqQ5GL51pIdbqNjMD0VJM1wHlcQn0EJnelfcbOu8jN
         Cro3mTA1KbJO/nxL36YbM58kEPYATcGOtkCNAC2yvR0A2Dc1GvFXvczqG6CXEYPepZTT
         6G6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=qTWgccEr99tvNib9c0TXHqLjF/qDPCnDy+II/n6qryg=;
        fh=3vasvzV3PWarSQU4ptWMrJZYWSFv15+BXbY1lciJg+k=;
        b=MX3sc2Cq0Ma7rlb/PqozZikhORZM7z1IPcxfgitkQAyvK2g5cfBFcZfEQG67ZvaG8x
         3oMMBuIb0JcSbFvwncRI6y5/zo+e0YS3hcxjW75PUo0PIgt17D9idB5rzhWdrFr6mGW8
         U37t3L6/6pDg5bihYfoIciHnnDa6Q+Q9IWdc36gFhyxgxsTDWozHF36EGxsyLYfKTFLi
         R2RrhyANBIi/Vol/Z0XrcbyjCogjmHKG0b4+ZoL3KdhAdxzuYarXfAj1XdwD2dfi0fbo
         wJRNatnkKTn6kJlR8FBRrzQswICYMp+Wg7NOd3eYBc4Qj9/vZD4tlVP/qtJLrGgD4qfk
         oJIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jqluv-com.20251104.gappssmtp.com; s=20251104; t=1775687530; x=1776292330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qTWgccEr99tvNib9c0TXHqLjF/qDPCnDy+II/n6qryg=;
        b=HaFHmRNTH8Oib5ih4a8uCFWXkrXa5Czc4zpSBr6tKSADPZj0Rr4czVTosJcnUnEYQk
         LFZtV6olMzWZYNuE34dVdJIANi7jUjM0fKSw4TrriTjd6eVm2UavsJE6gXFyM0WPqj4d
         XrHZC8xY+hqhx/I6htWFWO3rBcP+VBW1MB65CshcdMCFt2KOIV3iIqI2itVY+uDPdq8/
         yoYphlP3gVVy24peVQN7+bbhlcQeM6eBk2P/UZ5Isr1pnMMWqlSvAK79WKm/c5HlO9eF
         h4dS8XXWOOwvHbypekYcJSDk6MDkn7schUxCS9UAFzU4QxdRUL2EKzLo174/BwzEiOTL
         lF2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775687530; x=1776292330;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTWgccEr99tvNib9c0TXHqLjF/qDPCnDy+II/n6qryg=;
        b=Xt4K0qDzK2H/LVNjUqy625B9SJtirS8z2WzHAsDCfCYzAzYuov4cpp4XDj42Gc2eYK
         oW2XauYg0UGiPpb8F8CJ41Sh3OrC4VNF8rg+x1u024O6Gr1t+c7eClPyrB6M2CfRlu0Y
         5EF3dSgmWb84V9JvwKohrPhJBJG7/jvYBB8926HC/IoEYZwXbebFyM5zLNHKtXcMZOQl
         FYuIaTavWeEz3Ci6cKu7JI/hMG4mTHZHok6Uo2eEMnzWoAO46yps9sJ/IOFANP/wdbNw
         ms5iFdxKfHoTe+c2utRj8Paz9LDBxForDU96VUMl6kxciSg1z6Wv5M8rTlh5IG1m+txI
         HRWg==
X-Gm-Message-State: AOJu0Yz+KLjX9kXmZdtip60Ogzz3XZyG8H9aK6R8pme1lWZE96g2T6PW
	Ub5I5kJqlav7M+pW7KYhvBIY/UyQrnFXu4HsmaW6nMtZodnpMNklOL0om7UcN3ZqAg5q2HU+Ibt
	DqQksVF2Okm2A6fPNeckn5N+odE+piY5Z0+veNtS1cv6cFdoOkA26UKf4KyFT
X-Gm-Gg: AeBDiesUBnuA0bM/8Wjap8ruJk0eEmRlbI9WmaAWiIbbVLIzDKrrnUyO1vDaWmOQZlc
	NDUZ6llL06HpCHPXzAq5znXD/JuLD9wsJBOdPdQdzS9pybP++JIETy6/tQcDdUgYNqD0nhpV/F2
	xIIBUhXtwAFU3ChROv7dFDgzNrkWL05o8fyjUgx88y+mzjTPT2MT7NZcbE1IWMXca5KAkeAKX8w
	kuaS8/NX6ToDAc92GZAmNFeTEzEJwe6cFmbA7wKmWhNusntYc7BoSxNwNpfB7jTb8S1X5uocwcP
	s8dt
X-Received: by 2002:a05:622a:298e:b0:50b:3e4d:7ffa with SMTP id
 d75a77b69052e-50d62b191a6mr313634201cf.45.1775687529667; Wed, 08 Apr 2026
 15:32:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Geramy Loveless <gloveless@jqluv.com>
Date: Wed, 8 Apr 2026 15:31:59 -0700
X-Gm-Features: AQROBzAYRd2k4J9iQ-ethz1Ie32d9w_Wd4dppEmM_5LK5tSu3ozEdURBbY8cotQ
Message-ID: <CAGpo2meKY6SXsESU-D0PGgbESLqdF8UBF-tmThxOvk2XUDpEzw@mail.gmail.com>
Subject: [PATCH] PCI: release empty sibling resources during bridge window resize
To: linux-pci@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

When pci_resize_resource() walks up the bridge hierarchy via
pbus_reassign_bridge_resources(), bridge windows with any child
resources are refused release. This prevents BAR resize on devices
behind multi-port PCIe switches (such as Thunderbolt docks) where
empty sibling downstream ports hold small reservations that block the
parent bridge window from being freed and re-sized.

Add pci_bus_release_bridge_resources_safe() which verifies that a
resource subtree contains no active children before releasing it,
and use it in pbus_reassign_bridge_resources() to clear empty sibling
reservations so the bridge window can grow.

Signed-off-by: Geramy Loveless <gloveless@jqluv.com>
---
drivers/pci/setup-bus.c | 30 +++++++++++++++++++++++++++---
1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 4cf120ebe..9a3a23819 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2297,6 +2297,30 @@
EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
* release it when possible. If the bridge window contains assigned
* resources, it cannot be released.
*/
+
+/*
+ * Release child resources from a bridge window so it can be freed and
+ * re-sized, but only if the entire subtree is empty (no active device
+ * resources underneath). Walks the resource tree recursively to handle
+ * arbitrarily deep bridge hierarchies. Returns true if the resources
+ * were released or the window was already empty.
+ */
+static bool pci_bus_release_bridge_resources_safe(struct pci_bus *bus,
+ struct resource *res)
+{
+ struct resource *child;
+
+ for (child = res->child; child; child = child->sibling) {
+ if (child->child &&
+ !pci_bus_release_bridge_resources_safe(bus, child))
+ return false;
+ }
+
+ if (res->child)
+ pci_bus_release_bridge_resources(bus, res, whole_subtree);
+ return true;
+}
+
static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct
resource *res,
struct list_head *saved)
{
@@ -2316,8 +2340,8 @@ static int pbus_reassign_bridge_resources(struct
pci_bus *bus, struct resource *
i = pci_resource_num(bridge, res);
- /* Ignore BARs which are still in use */
- if (!res->child) {
+ if (!res->child ||
+ pci_bus_release_bridge_resources_safe(bridge->subordinate, res)) {
ret = pci_dev_res_add_to_list(saved, bridge, res, 0, 0);
if (ret)
return ret;
@@ -2327,7 +2351,7 @@ static int pbus_reassign_bridge_resources(struct
pci_bus *bus, struct resource *
const char *res_name = pci_resource_name(bridge, i);
pci_warn(bridge,
- "%s %pR: was not released (still contains assigned resources)\n",
+ "%s %pR: not released, active children present\n",
res_name, res);
}
-- 
2.51.0
