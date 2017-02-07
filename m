Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-dm3nam03on0095.outbound.protection.outlook.com ([104.47.41.95]:65056
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753322AbdBGQLh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Feb 2017 11:11:37 -0500
From: Jake Oshins <jakeo@microsoft.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Dexuan Cui <decui@microsoft.com>
CC: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [bug report] PCI: hv: Add paravirtual PCI front-end for Microsoft
 Hyper-V VMs
Date: Tue, 7 Feb 2017 16:11:33 +0000
Message-ID: <SN1PR0301MB15983BEA28AFC3DE344E2A4AAB430@SN1PR0301MB1598.namprd03.prod.outlook.com>
References: <20170207071219.GA15335@mwanda>
In-Reply-To: <20170207071219.GA15335@mwanda>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> -----Original Message-----
> From: Dan Carpenter [mailto:dan.carpenter@oracle.com]
> Sent: Monday, February 6, 2017 11:12 PM
> To: Jake Oshins <jakeo@microsoft.com>
> Cc: devel@linuxdriverproject.org; linux-pci@vger.kernel.org
> Subject: [bug report] PCI: hv: Add paravirtual PCI front-end for Microsof=
t
> Hyper-V VMs
>=20
> [ No idea why I haven never sent this email before.  I was just going
>   through all the use after free warnings again today and noticed it. ]
>=20
> Hello Jake Oshins,
>=20
> The patch 4daace0d8ce8: "PCI: hv: Add paravirtual PCI front-end for
> Microsoft Hyper-V VMs" from Feb 16, 2016, leads to the following
> static checker warning:
>=20
> 	drivers/pci/host/pci-hyperv.c:1441 pci_devices_present_work()
> 	error: dereferencing freed memory 'dr'
>=20
> drivers/pci/host/pci-hyperv.c
>   1410          /* Pull this off the queue and process it if it was the l=
ast one. */
>   1411          spin_lock_irqsave(&hbus->device_list_lock, flags);
>   1412          while (!list_empty(&hbus->dr_list)) {
>   1413                  dr =3D list_first_entry(&hbus->dr_list, struct hv=
_dr_state,
>   1414                                        list_entry);
>   1415                  list_del(&dr->list_entry);
>   1416
>   1417                  /* Throw this away if the list still has stuff in=
 it. */
>   1418                  if (!list_empty(&hbus->dr_list)) {
>   1419                          kfree(dr);
>                                 ^^^^^^^^^
> We free "dr".  Presumably we should set dr =3D NULL here?
>=20
>   1420                          continue;
>   1421                  }
>   1422          }
>   1423          spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>   1424
>   1425          if (!dr) {
>   1426                  up(&hbus->enum_sem);
>   1427                  put_hvpcibus(hbus);
>   1428                  return;
>   1429          }
>   1430
>   1431          /* First, mark all existing children as reported missing.=
 */
>   1432          spin_lock_irqsave(&hbus->device_list_lock, flags);
>   1433          list_for_each(iter, &hbus->children) {
>   1434                          hpdev =3D container_of(iter, struct hv_pc=
i_dev,
>   1435                                               list_entry);
>   1436                          hpdev->reported_missing =3D true;
>   1437          }
>   1438          spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>   1439
>   1440          /* Next, add back any reported devices. */
>   1441          for (child_no =3D 0; child_no < dr->device_count; child_n=
o++) {
>                                               ^^^^^^^^^^^^^^^^
> Use after free.
>=20
>   1442                  found =3D false;
>   1443                  new_desc =3D &dr->func[child_no];
>   1444
>   1445                  spin_lock_irqsave(&hbus->device_list_lock, flags)=
;
>=20
>=20
> regards,
> dan carpenter

I'm pretty sure that this is a false positive.  It only frees the struct if=
 there is another entry in the list, and then it immediately overwrites the=
 pointer with the next entry in the list.

What's the right move here?  Should we send a patch that nulls the pointer =
just to make a static analysis hit go away?  It's not a hot path.

Thanks,
Jake Oshins
