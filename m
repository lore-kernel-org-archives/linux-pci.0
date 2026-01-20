Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F236BCCE;
	Tue, 20 Jan 2026 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768911941; cv=none; b=Q7rjl49N+Amb/9beIuXZThF6IAkSnIgRs90DvhD8QPf+ZRhPyVz1s8wUPDyGCExE/Sksf/uoFEcHbhzKCyn7zHAfzggaF80jzgakD5ymBvKANiCp9TfvPFPsQFIOngMfC69hS6bGH6DFYUbC/fb+HNcYziaVTHhC9PZnIBhwEGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768911941; c=relaxed/simple;
	bh=zOWFyiV9G8Y96lNCKDdy3PRg3H3aNeGAD+Zwtx8cS5g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oby4dME72P9gzCDbXMrnlbTtG7AcolxDnes7RCa5du5bdNKLYi9F4OQApsDWbv8C6HHXppe3hCu+AcgxfpxRPyPK+RShzu9PUK+FKbgXVaghhXdB2EAIyul71NNtqEph2VOiuntwQZ0L7L4jBqnu6ilEeeZS5nJqC/PUyeMdJnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dwRNd4YGTzJ46Cf;
	Tue, 20 Jan 2026 20:25:05 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 125AB40571;
	Tue, 20 Jan 2026 20:25:30 +0800 (CST)
Received: from localhost (10.122.19.247) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 20 Jan
 2026 12:25:29 +0000
Date: Tue, 20 Jan 2026 12:25:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <dan.j.williams@intel.com>
CC: Terry Bowman <terry.bowman@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>, <bhelgaas@google.com>,
	<shiju.jose@huawei.com>, <ming.li@zohomail.com>,
	<Smita.KoralahalliChannabasappa@amd.com>, <rrichter@amd.com>,
	<dan.carpenter@linaro.org>, <PradeepVineshReddy.Kodamati@amd.com>,
	<lukas@wunner.de>, <Benjamin.Cheatham@amd.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <linux-cxl@vger.kernel.org>,
	<vishal.l.verma@intel.com>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v14 19/34] cxl/port: Fix devm resource leaks around with
 dport management
Message-ID: <20260120122527.0000680a@huawei.com>
In-Reply-To: <696eb7f160bbb_875d10053@dwillia2-mobl4.notmuch>
References: <20260114182055.46029-1-terry.bowman@amd.com>
	<20260114182055.46029-20-terry.bowman@amd.com>
	<20260115144605.00000666@huawei.com>
	<6969c260b7998_34d2a100f6@dwillia2-mobl4.notmuch>
	<20260116150119.00003bbd@huawei.com>
	<20260116161607.00005588@huawei.com>
	<696eb7f160bbb_875d10053@dwillia2-mobl4.notmuch>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 19 Jan 2026 15:02:09 -0800
dan.j.williams@intel.com wrote:

> Jonathan Cameron wrote:
> [..]
> > Any thoughts on what I'm missing? =20
>=20
> Probably:
>=20
>    cxl/port: Map Port component registers before switchport init
>=20
> ...which really should not be a distinct patch from the one that changes
> the ordering. I will send out a more patient series to settle this so
> Terry does not need to keep carrying it.
>=20
Ah. I stopped looking when I got to this patch :) Spot on - thanks!

Below is my suggestion of another approach. I think it ends up
a fair bit simpler, but you know this code a lot better than I do, so I may
be missing some problems! I like the simpler reaping. That approach looks
like it can be used elsewhere in this file.
Testing so far is one representative config only.

The patch you highlight above is squashed into this. At least one comment
I made on your patch applies here too (naughty me :)

=46rom a95567d9e2e3809ca1953a9aec24324ae13f6145 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Tue, 20 Jan 2026 10:53:14 +0000
Subject: [PATCH] Alternative to Dan's approach for managing dport resources.

Create a devres group to manage a subset of resources.
On success, close the devres group, but also stash a copy in
struct cxl_dport so we can use it for dport reaping.

On error, when group open release it.

Somewhat tested, but not what I'd consider exhaustive yet!
Used a 2 port switch, 2 EP test config.

1. Unbind endpoints, checked reap happened.
2. Unbind port1, check tear down happened.
3. Add some errors so some calls fail (stepping through each
   group that was created) Some cases get setup by
   it having another try based on a different downstream device
   arrival triggering the flow, but it seems fine.

  =20
---
 drivers/cxl/core/port.c       | 76 ++++++++++++++++++++---------------
 drivers/cxl/cxl.h             |  2 +
 drivers/cxl/cxlpci.h          |  4 ++
 tools/testing/cxl/test/mock.c |  1 +
 4 files changed, 51 insertions(+), 32 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fef3aa0c6680..e3c53b2fc78f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -778,7 +778,7 @@ static int cxl_setup_comp_regs(struct device *host, str=
uct cxl_register_map *map
 	return cxl_setup_regs(map);
 }
=20
-static int cxl_port_setup_regs(struct cxl_port *port,
+int cxl_port_setup_regs(struct cxl_port *port,
 			resource_size_t component_reg_phys)
 {
 	if (dev_is_platform(port->uport_dev))
@@ -786,6 +786,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
 	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
 				   component_reg_phys);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_port_setup_regs, "CXL");
=20
 static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dpo=
rt,
 				resource_size_t component_reg_phys)
@@ -1065,7 +1066,12 @@ static int add_dport(struct cxl_port *port, struct c=
xl_dport *dport)
 			dev_name(dup->dport_dev));
 		return -EBUSY;
 	}
-
+	//comment from original patch here.
+	if (!port->nr_dports) {
+		rc =3D cxl_port_setup_regs(port, port->component_reg_phys);
+		if (rc)
+			return rc;
+	}
 	rc =3D xa_insert(&port->dports, (unsigned long)dport->dport_dev, dport,
 		       GFP_KERNEL);
 	if (rc)
@@ -1181,20 +1187,6 @@ __devm_cxl_add_dport(struct cxl_port *port, struct d=
evice *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
=20
-	/*
-	 * Setup port register if this is the first dport showed up. Having
-	 * a dport also means that there is at least 1 active link.
-	 */
-	if (port->nr_dports =3D=3D 1 &&
-	    port->component_reg_phys !=3D CXL_RESOURCE_NONE) {
-		rc =3D cxl_port_setup_regs(port, port->component_reg_phys);
-		if (rc) {
-			xa_erase(&port->dports, (unsigned long)dport->dport_dev);
-			return ERR_PTR(rc);
-		}
-		port->component_reg_phys =3D CXL_RESOURCE_NONE;
-	}
-
 	get_device(dport_dev);
 	rc =3D devm_add_action_or_reset(host, cxl_dport_remove, dport);
 	if (rc)
@@ -1441,11 +1433,7 @@ static void delete_switch_port(struct cxl_port *port)
=20
 static void del_dport(struct cxl_dport *dport)
 {
-	struct cxl_port *port =3D dport->port;
-
-	devm_release_action(&port->dev, cxl_dport_unlink, dport);
-	devm_release_action(&port->dev, cxl_dport_remove, dport);
-	devm_kfree(&port->dev, dport);
+	devres_release_group(&dport->port->dev, dport->devres_group);
 }
=20
 static void del_dports(struct cxl_port *port)
@@ -1602,6 +1590,9 @@ static struct cxl_dport *cxl_port_add_dport(struct cx=
l_port *port,
 					    struct device *dport_dev)
 {
 	struct cxl_dport *dport;
+	struct cxl_dport *new_dport;
+	struct device *host;
+	void *devres_group;
 	int rc;
=20
 	device_lock_assert(&port->dev);
@@ -1615,21 +1606,31 @@ static struct cxl_dport *cxl_port_add_dport(struct =
cxl_port *port,
 		return ERR_PTR(-EBUSY);
 	}
=20
-	struct cxl_dport *new_dport __free(del_cxl_dport) =3D
-		devm_cxl_add_dport_by_dev(port, dport_dev);
-	if (IS_ERR(new_dport))
-		return new_dport;
+	if (is_cxl_root(port))
+		host =3D port->uport_dev;
+	else
+		host =3D &port->dev;
+
+	devres_group =3D devres_open_group(host, NULL, GFP_KERNEL);
+	if (!devres_group)
+		return ERR_PTR(-ENOMEM);
=20
-	cxl_switch_parse_cdat(new_dport);
+	if (port->nr_dports =3D=3D 0) {
+		rc =3D cxl_port_setup_regs(port, port->component_reg_phys);
+		if (rc)
+			goto release_group;
=20
-	if (ida_is_empty(&port->decoder_ida)) {
 		rc =3D devm_cxl_switch_port_decoders_setup(port);
 		if (rc)
-			return ERR_PTR(rc);
-		dev_dbg(&port->dev, "first dport%d:%s added with decoders\n",
-			new_dport->port_id, dev_name(dport_dev));
-		return no_free_ptr(new_dport);
+			goto release_group;
+	}
+
+	new_dport =3D devm_cxl_add_dport_by_dev(port, dport_dev);
+	if (IS_ERR(new_dport)) {
+		rc =3D PTR_ERR(new_dport);
+		goto release_group;
 	}
+	cxl_switch_parse_cdat(new_dport);
=20
 	/* New dport added, update the decoder targets */
 	device_for_each_child(&port->dev, new_dport, update_decoder_targets);
@@ -1637,7 +1638,18 @@ static struct cxl_dport *cxl_port_add_dport(struct c=
xl_port *port,
 	dev_dbg(&port->dev, "dport%d:%s added\n", new_dport->port_id,
 		dev_name(dport_dev));
=20
-	return no_free_ptr(new_dport);
+	/*
+	 * Stash the group for use during reaping when all downstream devices
+	 * go away.
+	 */
+	new_dport->devres_group =3D devres_group;
+	devres_close_group(host, devres_group);
+
+	return new_dport;
+
+release_group:
+	devres_release_group(host, devres_group);
+	return ERR_PTR(rc);
 }
=20
 static struct cxl_dport *devm_cxl_create_port(struct device *ep_dev,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c796c3db36e0..855f7629f5c4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -688,6 +688,7 @@ struct cxl_rcrb_info {
  * @coord: access coordinates (bandwidth and latency performance attribute=
s)
  * @link_latency: calculated PCIe downstream latency
  * @gpf_dvsec: Cached GPF port DVSEC
+ * @devres_group: Used to simplify reaping ports.
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -700,6 +701,7 @@ struct cxl_dport {
 	struct access_coordinate coord[ACCESS_COORDINATE_MAX];
 	long link_latency;
 	int gpf_dvsec;
+	void *devres_group;
 };
=20
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 1d526bea8431..a3fbedb66dbb 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -132,4 +132,8 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+
+int cxl_port_setup_regs(struct cxl_port *port,
+			resource_size_t component_reg_phys);
+
 #endif /* __CXL_PCI_H__ */


