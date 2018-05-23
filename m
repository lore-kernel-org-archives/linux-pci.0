Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] pci/hotplug/pnv-php: add missing of_node_put
Date: Wed, 23 May 2018 21:07:15 +0200
Message-Id: <1527102436-13447-5-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1527102436-13447-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The device node iterators perform an of_node_get on each iteration, so a
jump out of the loop requires an of_node_put.

The semantic patch that fixes this problem is as follows
(http://coccinelle.lip6.fr):

// <smpl>
@@
expression root,e;
local idexpression child;
iterator name for_each_child_of_node;
@@

 for_each_child_of_node(root, child) {
   ... when != of_node_put(child)
       when != e = child
+  of_node_put(child);
?  break;
   ...
}
... when != child
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/pci/hotplug/pnv_php.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index d441006..6c2e8d7 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -220,12 +220,16 @@ static int pnv_php_populate_changeset(struct of_changeset *ocs,
 
 	for_each_child_of_node(dn, child) {
 		ret = of_changeset_attach_node(ocs, child);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			break;
+		}
 
 		ret = pnv_php_populate_changeset(ocs, child);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			break;
+		}
 	}
 
 	return ret;
