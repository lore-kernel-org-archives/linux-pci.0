Return-Path: <SRS0=mLR+=OX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0389C43387
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 20:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29E1206DD
	for <linux-pci@archiver.kernel.org>; Fri, 14 Dec 2018 20:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731169AbeLNUvh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:51:37 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730855AbeLNUvg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Dec 2018 15:51:36 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBEKmuLl024807
        for <linux-pci@vger.kernel.org>; Fri, 14 Dec 2018 15:51:35 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pchv3n63e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-pci@vger.kernel.org>; Fri, 14 Dec 2018 15:51:35 -0500
Received: from localhost
        by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pci@vger.kernel.org> from <mwb@linux.vnet.ibm.com>;
        Fri, 14 Dec 2018 20:51:35 -0000
Received: from b03cxnp07029.gho.boulder.ibm.com (9.17.130.16)
        by e35.co.us.ibm.com (192.168.1.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 14 Dec 2018 20:51:32 -0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBEKpVBu22479064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Dec 2018 20:51:31 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 812156E056;
        Fri, 14 Dec 2018 20:51:31 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 691906E052;
        Fri, 14 Dec 2018 20:51:31 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (unknown [9.40.192.78])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 14 Dec 2018 20:51:31 +0000 (GMT)
Received: from powerkvm6.aus.stglabs.ibm.com (localhost [IPv6:::1])
        by powerkvm6.aus.stglabs.ibm.com (Postfix) with ESMTP id 23FA140E516A;
        Fri, 14 Dec 2018 14:51:31 -0600 (CST)
Subject: [RFC 5/6] powerpc/pci/hotplug: Use common drcinfo parsing
From:   Michael Bringmann <mwb@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>
Date:   Fri, 14 Dec 2018 14:51:31 -0600
In-Reply-To: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
References: <20181214204914.16435.59083.stgit@powerkvm6.aus.stglabs.ibm.com>
User-Agent: StGit/0.18-105-g416a-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18121420-0012-0000-0000-000016EA0958
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010225; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000271; SDB=6.01131804; UDB=6.00588226; IPR=6.00911936;
 MB=3.00024694; MTD=3.00000008; XFM=3.00000015; UTC=2018-12-14 20:51:34
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18121420-0013-0000-0000-00005575E24E
Message-Id: <20181214205120.16435.46952.stgit@powerkvm6.aus.stglabs.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-14_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812140176
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The implementation of the pseries-specific drc info properties
is currently implemented in pseries-specific and non-pseries-specific
files.  This patch set uses a new implementation of the device-tree
parsing code for the properties.

This patch refactors parsing of the pseries-specific drc-info properties
out of rpaphp_core.c to use the common parser.  In the case where an
architecture does not use these properties, an __weak copy of the
function is provided with dummy return values.  Changes include creating
appropriate callback functions and passing callback-specific data
blocks into arch_find_drc_match.  All functions that were used just
to support the previous parsing implementation have been moved.

Signed-off-by: Michael Bringmann <mwb@linux.vnet.ibm.com>
---
 drivers/pci/hotplug/rpaphp_core.c |  232 ++++---------------------------------
 1 file changed, 28 insertions(+), 204 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index bcd5d35..9ad7384 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -154,182 +154,18 @@ static enum pci_bus_speed get_max_bus_speed(struct slot *slot)
 	return speed;
 }
 
-static int get_children_props(struct device_node *dn, const int **drc_indexes,
-		const int **drc_names, const int **drc_types,
-		const int **drc_power_domains)
-{
-	const int *indexes, *names, *types, *domains;
-
-	indexes = of_get_property(dn, "ibm,drc-indexes", NULL);
-	names = of_get_property(dn, "ibm,drc-names", NULL);
-	types = of_get_property(dn, "ibm,drc-types", NULL);
-	domains = of_get_property(dn, "ibm,drc-power-domains", NULL);
-
-	if (!indexes || !names || !types || !domains) {
-		/* Slot does not have dynamically-removable children */
-		return -EINVAL;
-	}
-	if (drc_indexes)
-		*drc_indexes = indexes;
-	if (drc_names)
-		/* &drc_names[1] contains NULL terminated slot names */
-		*drc_names = names;
-	if (drc_types)
-		/* &drc_types[1] contains NULL terminated slot types */
-		*drc_types = types;
-	if (drc_power_domains)
-		*drc_power_domains = domains;
-
-	return 0;
-}
-
-
 /* Verify the existence of 'drc_name' and/or 'drc_type' within the
- * current node.  First obtain it's my-drc-index property.  Next,
- * obtain the DRC info from it's parent.  Use the my-drc-index for
- * correlation, and obtain/validate the requested properties.
+ * current node.
  */
 
-static int rpaphp_check_drc_props_v1(struct device_node *dn, char *drc_name,
-				char *drc_type, unsigned int my_index)
-{
-	char *name_tmp, *type_tmp;
-	const int *indexes, *names;
-	const int *types, *domains;
-	int i, rc;
-
-	rc = get_children_props(dn->parent, &indexes, &names, &types, &domains);
-	if (rc < 0) {
-		return -EINVAL;
-	}
-
-	name_tmp = (char *) &names[1];
-	type_tmp = (char *) &types[1];
-
-	/* Iterate through parent properties, looking for my-drc-index */
-	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
-		if ((unsigned int) indexes[i + 1] == my_index)
-			break;
-
-		name_tmp += (strlen(name_tmp) + 1);
-		type_tmp += (strlen(type_tmp) + 1);
-	}
-
-	if (((drc_name == NULL) || (drc_name && !strcmp(drc_name, name_tmp))) &&
-	    ((drc_type == NULL) || (drc_type && !strcmp(drc_type, type_tmp))))
-		return 0;
-
-	return -EINVAL;
-}
-
-static int rpaphp_check_drc_props_v2(struct device_node *dn, char *drc_name,
-				char *drc_type, unsigned int my_index)
-{
-	struct property *info;
-	unsigned int entries;
-	struct of_drc_info drc;
-	const __be32 *value;
-	char cell_drc_name[MAX_DRC_NAME_LEN];
-	int j, fndit;
-
-	info = of_find_property(dn->parent, "ibm,drc-info", NULL);
-	if (info == NULL)
-		return -EINVAL;
-
-	value = of_prop_next_u32(info, NULL, &entries);
-	if (!value)
-		return -EINVAL;
-
-	for (j = 0; j < entries; j++) {
-		of_read_drc_info_cell(&info, &value, &drc);
-
-		/* Should now know end of current entry */
-
-		if (my_index > drc.last_drc_index)
-			continue;
-
-		fndit = 1;
-		break;
-	}
-	/* Found it */
-
-	if (fndit)
-		sprintf(cell_drc_name, "%s%d", drc.drc_name_prefix, 
-			my_index);
-
-	if (((drc_name == NULL) ||
-	     (drc_name && !strcmp(drc_name, cell_drc_name))) &&
-	    ((drc_type == NULL) ||
-	     (drc_type && !strcmp(drc_type, drc.drc_type))))
-		return 0;
-
-	return -EINVAL;
-}
-
 int rpaphp_check_drc_props(struct device_node *dn, char *drc_name,
 			char *drc_type)
 {
-	const unsigned int *my_index;
-
-	my_index = of_get_property(dn, "ibm,my-drc-index", NULL);
-	if (!my_index) {
-		/* Node isn't DLPAR/hotplug capable */
-		return -EINVAL;
-	}
-
-	if (firmware_has_feature(FW_FEATURE_DRC_INFO))
-		return rpaphp_check_drc_props_v2(dn, drc_name, drc_type,
-						*my_index);
-	else
-		return rpaphp_check_drc_props_v1(dn, drc_name, drc_type,
-						*my_index);
+	return arch_find_drc_match(dn, NULL, drc_type, drc_name,
+				true, false, NULL);
 }
 EXPORT_SYMBOL_GPL(rpaphp_check_drc_props);
 
-
-static int is_php_type(char *drc_type)
-{
-	unsigned long value;
-	char *endptr;
-
-	/* PCI Hotplug nodes have an integer for drc_type */
-	value = simple_strtoul(drc_type, &endptr, 10);
-	if (endptr == drc_type)
-		return 0;
-
-	return 1;
-}
-
-/**
- * is_php_dn() - return 1 if this is a hotpluggable pci slot, else 0
- * @dn: target &device_node
- * @indexes: passed to get_children_props()
- * @names: passed to get_children_props()
- * @types: returned from get_children_props()
- * @power_domains:
- *
- * This routine will return true only if the device node is
- * a hotpluggable slot. This routine will return false
- * for built-in pci slots (even when the built-in slots are
- * dlparable.)
- */
-static int is_php_dn(struct device_node *dn, const int **indexes,
-		const int **names, const int **types, const int **power_domains)
-{
-	const int *drc_types;
-	int rc;
-
-	rc = get_children_props(dn, indexes, names, &drc_types, power_domains);
-	if (rc < 0)
-		return 0;
-
-	if (!is_php_type((char *) &drc_types[1]))
-		return 0;
-
-	*types = drc_types;
-	return 1;
-}
-
 /**
  * rpaphp_add_slot -- declare a hotplug slot to the hotplug subsystem.
  * @dn: device node of slot
@@ -346,54 +182,42 @@ static int is_php_dn(struct device_node *dn, const int **indexes,
  *
  * To remove a slot, it suffices to call rpaphp_deregister_slot().
  */
-int rpaphp_add_slot(struct device_node *dn)
+
+static int rpaphp_add_slot_cb(struct device_node *dn,
+			u32 drc_index, char *drc_name, char *drc_type,
+			u32 drc_power_domain, void *data)
 {
 	struct slot *slot;
 	int retval = 0;
-	int i;
-	const int *indexes, *names, *types, *power_domains;
-	char *name, *type;
-
-	if (!dn->name || strcmp(dn->name, "pci"))
-		return 0;
-
-	/* If this is not a hotplug slot, return without doing anything. */
-	if (!is_php_dn(dn, &indexes, &names, &types, &power_domains))
-		return 0;
-
-	dbg("Entry %s: dn=%pOF\n", __func__, dn);
 
-	/* register PCI devices */
-	name = (char *) &names[1];
-	type = (char *) &types[1];
-	for (i = 0; i < be32_to_cpu(indexes[0]); i++) {
-		int index;
+	slot = alloc_slot_struct(dn, drc_index, drc_name, drc_power_domain);
+	if (!slot)
+		return -ENOMEM;
 
-		index = be32_to_cpu(indexes[i + 1]);
-		slot = alloc_slot_struct(dn, index, name,
-					 be32_to_cpu(power_domains[i + 1]));
-		if (!slot)
-			return -ENOMEM;
+	slot->type = simple_strtoul(drc_type, NULL, 10);
+	if (retval)
+		return -EINVAL;
 
-		slot->type = simple_strtoul(type, NULL, 10);
+	dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
+		drc_index, drc_name, drc_type);
 
-		dbg("Found drc-index:0x%x drc-name:%s drc-type:%s\n",
-				index, name, type);
+	retval = rpaphp_enable_slot(slot);
+	if (!retval)
+		retval = rpaphp_register_slot(slot);
 
-		retval = rpaphp_enable_slot(slot);
-		if (!retval)
-			retval = rpaphp_register_slot(slot);
+	if (retval)
+		dealloc_slot_struct(slot);
 
-		if (retval)
-			dealloc_slot_struct(slot);
+	return retval;
+}
 
-		name += strlen(name) + 1;
-		type += strlen(type) + 1;
-	}
-	dbg("%s - Exit: rc[%d]\n", __func__, retval);
+int rpaphp_add_slot(struct device_node *dn)
+{
+	if (!dn->name || strcmp(dn->name, "pci"))
+		return 0;
 
-	/* XXX FIXME: reports a failure only if last entry in loop failed */
-	return retval;
+	return arch_find_drc_match(dn, rpaphp_add_slot_cb,
+			NULL, NULL, false, true, NULL);
 }
 EXPORT_SYMBOL_GPL(rpaphp_add_slot);
 

