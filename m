Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bk0-f44.google.com ([209.85.214.44]:61995 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755133Ab3GTVlB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 20 Jul 2013 17:41:01 -0400
Received: by mail-bk0-f44.google.com with SMTP id 6so2048978bkj.17
        for <linux-pci@vger.kernel.org>; Sat, 20 Jul 2013 14:40:59 -0700 (PDT)
MIME-Version: 1.0
From: Tom Gundersen <teg@jklm.no>
Date: Sat, 20 Jul 2013 23:40:38 +0200
Message-ID: <CAG-2HqUUznNH3oM=qCnuQ6d6oGeuHeEiP_0+6FD96d8SewKoug@mail.gmail.com>
Subject: [PATCH][pciutils] libpci: pci_id_lookup - add udev/hwdb support
To: linux-pci@vger.kernel.org
Cc: Tom Gundersen <teg@jklm.no>, systemd-devel@lists.freedesktop.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Small correction to the subject, it should have said:

[PATCH][pciutils] libpci: pci_id_lookup - add udev/hwdb support

On Sat, Jul 20, 2013 at 10:44 PM, Tom Gundersen <teg@jklm.no> wrote:
> This lets you select hwdb support at compile time.
>
> hwdb is an efficient hardware database shipped with recent versions of systemd/udev. It contains
> among other sources pci.ids so querying hwdb rather than reading pci.ids directly should give
> the same result.
>
> Ideally Linux distros using systemd would like to not ship pci.ids, but use hwdb as the only source
> of this information, which this patch allows.
>
> Cc: systemd-devel@lists.freedesktop.org
>
> ---
>  lib/configure    | 17 ++++++++++++++++
>  lib/names-hash.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/lib/configure b/lib/configure
> index 4ae20d4..674d3ea 100755
> --- a/lib/configure
> +++ b/lib/configure
> @@ -141,6 +141,23 @@ esac
>  echo >>$c '#define PCI_HAVE_PM_DUMP'
>  echo " dump"
>
> +echo_n "Checking for udev hwdb support... "
> +if [ "$HWDB" = yes -o "$HWDB" = no ] ; then
> +       echo "$HWDB (set manually)"
> +else
> +       if [ -f /usr/include/libudev.h -o -f /usr/local/include/libudev.h ] ; then
> +               HWDB=yes
> +       else
> +               HWDB=no
> +       fi
> +       echo "$HWDB (auto-detected)"
> +fi
> +if [ "$HWDB" = yes ] ; then
> +       echo >>$c '#define PCI_HAVE_HWDB'
> +       echo >>$m 'LIBUDEV=-ludev'
> +       echo >>$m 'WITH_LIBS+=$(LIBUDEV)'
> +fi
> +
>  echo_n "Checking for zlib support... "
>  if [ "$ZLIB" = yes -o "$ZLIB" = no ] ; then
>         echo "$ZLIB (set manually)"
> diff --git a/lib/names-hash.c b/lib/names-hash.c
> index 33f3c11..9661d03 100644
> --- a/lib/names-hash.c
> +++ b/lib/names-hash.c
> @@ -11,6 +11,11 @@
>  #include "internal.h"
>  #include "names.h"
>
> +#ifdef PCI_HAVE_HWDB
> +#include <libudev.h>
> +#include <stdio.h>
> +#endif
> +
>  struct id_bucket {
>    struct id_bucket *next;
>    unsigned int full;
> @@ -86,8 +91,58 @@ char
>  *pci_id_lookup(struct pci_access *a, int flags, int cat, int id1, int id2, int id3, int id4)
>  {
>    struct id_entry *n, *best;
> -  u32 id12 = id_pair(id1, id2);
> -  u32 id34 = id_pair(id3, id4);
> +  u32 id12, id34;
> +
> +#ifdef PCI_HAVE_HWDB
> +  if (!(flags & PCI_LOOKUP_SKIP_LOCAL))
> +    {
> +      char modalias[64];
> +      const char *key = NULL;
> +      struct udev *udev = udev_new();
> +      struct udev_hwdb *hwdb = udev_hwdb_new(udev);
> +      struct udev_list_entry *entry;
> +
> +      switch(cat)
> +        {
> +        case ID_VENDOR:
> +          sprintf(modalias, "pci:v%08X*", id1);
> +          key = "ID_VENDOR_FROM_DATABASE";
> +          break;
> +        case ID_DEVICE:
> +          sprintf(modalias, "pci:v%08Xd%08X*", id1, id2);
> +          key = "ID_MODEL_FROM_DATABASE";
> +          break;
> +        case ID_SUBSYSTEM:
> +          sprintf(modalias, "pci:v%08Xd%08Xsv%08Xsd%08X*", id1, id2, id3, id4);
> +          key = "ID_MODEL_FROM_DATABASE";
> +          break;
> +        case ID_GEN_SUBSYSTEM:
> +          sprintf(modalias, "pci:v*d*sv%08Xsd%08X*", id1, id2);
> +          key = "ID_MODEL_FROM_DATABASE";
> +          break;
> +        case ID_CLASS:
> +          sprintf(modalias, "pci:v*d*sv*sd*bc%02X*", id1);
> +          key = "ID_PCI_CLASS_FROM_DATABASE";
> +          break;
> +        case ID_SUBCLASS:
> +          sprintf(modalias, "pci:v*d*sv*sd*bc%02Xsc%02X*", id1, id2);
> +          key = "ID_PCI_SUBCLASS_FROM_DATABASE";
> +          break;
> +        case ID_PROGIF:
> +          sprintf(modalias, "pci:v*d*sv*sd*bc%02Xsc%02Xi%02X*", id1, id2, id3);
> +          key = "ID_PCI_INTERFACE_FROM_DATABASE";
> +          break;
> +        }
> +
> +      if (key)
> +          udev_list_entry_foreach(entry, udev_hwdb_get_properties_list_entry(hwdb, modalias, 0))
> +              if (strcmp(udev_list_entry_get_name(entry), key) == 0)
> +                return udev_list_entry_get_value(entry);
> +    }
> +#endif
> +
> +  id12 = id_pair(id1, id2);
> +  id34 = id_pair(id3, id4);
>
>    if (a->id_hash)
>      {
> --
> 1.8.3.3
>
