Return-Path: <SRS0=l5Zs=7V=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=l5Zs=7V=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170819025551.GP28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1501858648-22228-1-git-send-email-srinath.mannam@broadcom.com>
 <20170816134354.GV32525@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4ip3m4U_i4k-8hBcONONLXyy83v-BeWk7Rq24CD9Z-9w@mail.gmail.com> <20170819025551.GP28977@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Sat, 19 Aug 2017 08:55:16 +0530
Message-ID: <CABe79T63p4BBeTECitda+w6jp2buv4DZCgu3wRjtm_=P+hONjA@mail.gmail.com>
Subject: Re: [RFC PATCH v3] pci: Concurrency issue during pci enable bridge
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Content-Type: multipart/alternative; boundary="001a113cfa3e684c1d055712cb66"
List-ID: <linux-pci.vger.kernel.org>

--001a113cfa3e684c1d055712cb66
Content-Type: text/plain; charset="UTF-8"

Hi Bjorn,

Thank you for your guidance.

Regards,
Srinath.

On 19-Aug-2017 8:25 AM, "Bjorn Helgaas" <helgaas@kernel.org> wrote:

> On Wed, Aug 16, 2017 at 10:33:12PM +0530, Srinath Mannam wrote:
> > Hi Bjorn,
> >
> > Thank you for the feedback.
> >
> > My comments are in lined.
> >
> > On Wed, Aug 16, 2017 at 7:13 PM, Bjorn Helgaas <helgaas@kernel.org>
> wrote:
> > > On Fri, Aug 04, 2017 at 08:27:28PM +0530, Srinath Mannam wrote:
> > >> Concurrency issue is observed during pci enable bridge called
> > >> for multiple pci devices initialization in SMP system.
> > >>
> > >> Setup details:
> > >>  - SMP system with 8 ARMv8 cores running Linux kernel(4.11).
> > >>  - Two EPs are connected to PCIe RC through bridge as shown
> > >>    in the below figure.
> > >>
> > >>                    [RC]
> > >>                     |
> > >>                  [BRIDGE]
> > >>                     |
> > >>                -----------
> > >>               |           |
> > >>              [EP]        [EP]
> > >>
> > >> Issue description:
> > >> After PCIe enumeration completed EP driver probe function called
> > >> for both the devices from two CPUS simultaneously.
> > >> From EP probe function, pci_enable_device_mem called for both the EPs.
> > >> This function called pci_enable_bridge enable for all the bridges
> > >> recursively in the path of EP to RC.
> > >>
> > >> Inside pci_enable_bridge function, at two places concurrency issue is
> > >> observed.
> > >>
> > >> Place 1:
> > >>   CPU 0:
> > >>     1. Done Atomic increment dev->enable_cnt
> > >>        in pci_enable_device_flags
> > >>     2. Inside pci_enable_resources
> > >>     3. Completed pci_read_config_word(dev, PCI_COMMAND, &cmd)
> > >>     4. Ready to set PCI_COMMAND_MEMORY (0x2) in
> > >>        pci_write_config_word(dev, PCI_COMMAND, cmd)
> > >>   CPU 1:
> > >>     1. Check pci_is_enabled in function pci_enable_bridge
> > >>        and it is true
> > >>     2. Check (!dev->is_busmaster) also true
> > >>     3. Gone into pci_set_master
> > >>     4. Completed pci_read_config_word(dev, PCI_COMMAND, &old_cmd)
> > >>     5. Ready to set PCI_COMMAND_MASTER (0x4) in
> > >>        pci_write_config_word(dev, PCI_COMMAND, cmd)
> > >>
> > >> By the time of last point for both the CPUs are read value 0 and
> > >> ready to write 2 and 4.
> > >> After last point final value in PCI_COMMAND register is 4 instead of
> 6.
> > >>
> > >> Place 2:
> > >>   CPU 0:
> > >>     1. Done Atomic increment dev->enable_cnt in
> > >>        pci_enable_device_flags
> > >>
> > >> Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
> > >> ---
> > >>  drivers/pci/pci.c | 8 ++++++--
> > >>  1 file changed, 6 insertions(+), 2 deletions(-)
> > >>
> > >> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > >> index af0cc34..12721df 100644
> > >> --- a/drivers/pci/pci.c
> > >> +++ b/drivers/pci/pci.c
> > >> @@ -52,6 +52,7 @@ static void pci_pme_list_scan(struct work_struct
> *work);
> > >>  static LIST_HEAD(pci_pme_list);
> > >>  static DEFINE_MUTEX(pci_pme_list_mutex);
> > >>  static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
> > >> +static DEFINE_MUTEX(pci_bridge_mutex);
> > >>
> > >>  struct pci_pme_device {
> > >>       struct list_head list;
> > >> @@ -1348,10 +1349,11 @@ static void pci_enable_bridge(struct pci_dev
> *dev)
> > >>       if (bridge)
> > >>               pci_enable_bridge(bridge);
> > >>
> > >> +     mutex_lock(&pci_bridge_mutex);
> > >>       if (pci_is_enabled(dev)) {
> > >>               if (!dev->is_busmaster)
> > >>                       pci_set_master(dev);
> > >> -             return;
> > >> +             goto end;
> > >>       }
> > >>
> > >>       retval = pci_enable_device(dev);
> > >> @@ -1359,6 +1361,8 @@ static void pci_enable_bridge(struct pci_dev
> *dev)
> > >>               dev_err(&dev->dev, "Error enabling bridge (%d),
> continuing\n",
> > >>                       retval);
> > >>       pci_set_master(dev);
> > >> +end:
> > >> +     mutex_unlock(&pci_bridge_mutex);
> > >
> > > I think this will deadlock because we're holding pci_bridge_mutex
> > > while we call pci_enable_device(), which may recursively call
> > > pci_enable_bridge(), which would try to acquire pci_bridge_mutex
> > > again.  My original suggestion of a mutex in the host bridge would
> > > have the same problem.
> >
> > This extra check "if (bridge && !pci_is_enabled(bridge))" will resolve
> > the deadlock in the present patch.
>
> Oh, I see.  In pci_enable_bridge(X), the recursive call to enable
> upstream bridges happens *before* acquiring pci_bridge_mutex, so when
> we call pci_enable_device(X) while holding the mutex, any upstream
> bridges will have been already enabled.
>
> We recurse all the way to the top of the hierarchy, acquire the mutex,
> enable the bridge, release the mutex, then unwind and repeat for each
> bridge on the way down to the endpoint.
>
> > > We talked about using device_lock() earlier.  You found some problems
> > > with that, and I'd like to understand them better.  You said:
> > >
> > >> But the pci_enable_bridge is called in the context of the driver
> > >> probe function, we will have nexted lock problem.
> > >
> > > The driver core does hold device_lock() while calling the driver probe
> > > function, in this path:
> > >
> > >   device_initial_probe
> > >     __device_attach
> > >       device_lock(dev)                # <-- lock
> > >       __device_attach_driver
> > >         ...
> > >           pci_device_probe
> > >             ...
> > >               ->probe                 # driver probe function
> > >       device_unlock(dev)              # <-- unlock
> > >
> > > I didn't see your patch using device_lock(), but what I had in mind
> > > was something like the patch below, where pci_enable_bridge() acquires
> > > the device_lock() of the bridge.
> > >
> > > For the sake of argument, assume a hierarchy:
> > >
> > >   bridge A -> bridge B -> endpoint C
> > >
> > > Here's what I think will happen:
> > >
> > >   device_lock(C)                         # driver core
> > >     ...
> > >       ->probe(C)                         # driver probe function
> > >         pci_enable_device_flags(C)
> > >           pci_enable_bridge(B)           # enable C's upstream bridge
> > >             device_lock(B)
> > >             pci_enable_bridge(A)         # enable B's upstream bridge
> > >               device_lock(A)             # A has no upstream bridge
> > >               pci_enable_device(A)
> > >                 do_pci_enable_device(A)  # update A PCI_COMMAND
> > >               pci_set_master(A)          # update A PCI_COMMAND
> > >               device_unlock(A)
> > >             pci_enable_device(B)         # update B PCI_COMMAND
> > >             pci_set_master(B)            # update B PCI_COMMAND
> > >             device_unlock(B)
> > >           do_pci_enable_device(C)        # update C PCI_COMMAND
> > >   device_unlock(C)
> > >
> > > I don't see a nested lock problem here.  What am I missing?
> > From the probe call device_lock will taken to that endpoint and also
> > for the bus. In this order
> >
> > pci register driver(C)              #(driver_register())
> > device_lock(B);                       # lock for parent
> (__driver_attach())
> > device_lock(C)                       # lock for endpoint
> (__driver_attach())
> > driver probe(C)
> > pci_enable_bridge()
> > device_lock(B);  # here we see the deadlock.because of parent device lock
>
> Oh, it's the "needed for USB" thing in __driver_attach();
> is that right?
>
>         if (dev->parent)        /* Needed for USB */
>                 device_lock(dev->parent);
>         device_lock(dev);
>
> Looks like that came from bf74ad5bc417 ("[PATCH] Hold the device's
> parent's lock during probe and remove"), and it's probably not
> practical to change it, even if it's not strictly needed for PCI.
>
> So I think your patch is correct and I applied it to pci/enumeration
> for v4.14.  Thanks for your patience.
>
> I didn't quite understand the "Place 2" concurrency issue in your
> changelog.  I *think* I understand "Place 1", and I updated the
> changelog with an ordering that I think illustrates the problem and
> added a comment to that effect in the code.
>
>
> commit 40f11adc7cd9281227f0a6a627d966dd0a5f0cd9
> Author: Srinath Mannam <srinath.mannam@broadcom.com>
> Date:   Fri Aug 18 21:50:48 2017 -0500
>
>     PCI: Avoid race while enabling upstream bridges
>
>     When we enable a device, we first enable any upstream bridges.  If a
> bridge
>     has multiple downstream devices and we enable them simultaneously, the
> race
>     to enable the upstream bridge may cause problems.  Consider this
> hierarchy:
>
>       bridge A --+-- device B
>                  +-- device C
>
>     If drivers for B and C call pci_enable_device() simultaneously, both
> will
>     attempt to enable A, which involves setting PCI_COMMAND_MASTER via
>     pci_set_master() and PCI_COMMAND_MEMORY via pci_enable_resources().
>
>     In the following sequence, B's update to set A's PCI_COMMAND_MEMORY is
>     lost, and neither B nor C will work correctly:
>
>           B                                C
>       pci_set_master(A)
>         cmd = read(A, PCI_COMMAND)
>         cmd |= PCI_COMMAND_MASTER
>                                        pci_set_master(A)
>                                          cmd = read(A, PCI_COMMAND)
>                                          cmd |= PCI_COMMAND_MASTER
>         write(A, PCI_COMMAND, cmd)
>       pci_enable_device(A)
>         pci_enable_resources(A)
>           cmd = read(A, PCI_COMMAND)
>           cmd |= PCI_COMMAND_MEMORY
>           write(A, PCI_COMMAND, cmd)
>                                          write(A, PCI_COMMAND, cmd)
>
>     Avoid this race by holding a new pci_bridge_mutex while enabling a
> bridge.
>     This ensures that both PCI_COMMAND_MASTER and PCI_COMMAND_MEMORY will
> be
>     updated before another thread can start enabling the bridge.
>
>     Note that although pci_enable_bridge() is recursive, it enables any
>     upstream bridges *before* acquiring the mutex.  When it acquires the
> mutex
>     and calls pci_set_master() and pci_enable_device(), any upstream
> bridges
>     have already been enabled so pci_enable_device() will not deadlock by
>     calling pci_enable_bridge() again.
>
>     Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
>     [bhelgaas: changelog, comment]
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index af0cc3456dc1..7cb29a223b73 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -52,6 +52,7 @@ static void pci_pme_list_scan(struct work_struct *work);
>  static LIST_HEAD(pci_pme_list);
>  static DEFINE_MUTEX(pci_pme_list_mutex);
>  static DECLARE_DELAYED_WORK(pci_pme_work, pci_pme_list_scan);
> +static DEFINE_MUTEX(pci_bridge_mutex);
>
>  struct pci_pme_device {
>         struct list_head list;
> @@ -1348,10 +1349,16 @@ static void pci_enable_bridge(struct pci_dev *dev)
>         if (bridge)
>                 pci_enable_bridge(bridge);
>
> +       /*
> +        * Hold pci_bridge_mutex to prevent a race when enabling two
> +        * devices below the bridge simultaneously.  The race may cause a
> +        * PCI_COMMAND_MEMORY update to be lost (see changelog).
> +        */
> +       mutex_lock(&pci_bridge_mutex);
>         if (pci_is_enabled(dev)) {
>                 if (!dev->is_busmaster)
>                         pci_set_master(dev);
> -               return;
> +               goto end;
>         }
>
>         retval = pci_enable_device(dev);
> @@ -1359,6 +1366,8 @@ static void pci_enable_bridge(struct pci_dev *dev)
>                 dev_err(&dev->dev, "Error enabling bridge (%d),
> continuing\n",
>                         retval);
>         pci_set_master(dev);
> +end:
> +       mutex_unlock(&pci_bridge_mutex);
>  }
>
>  static int pci_enable_device_flags(struct pci_dev *dev, unsigned long
> flags)
> @@ -1383,7 +1392,7 @@ static int pci_enable_device_flags(struct pci_dev
> *dev, unsigned long flags)
>                 return 0;               /* already enabled */
>
>         bridge = pci_upstream_bridge(dev);
> -       if (bridge)
> +       if (bridge && !pci_is_enabled(bridge))
>                 pci_enable_bridge(bridge);
>
>         /* only skip sriov related */
>

--001a113cfa3e684c1d055712cb66
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Bjorn,<div dir=3D"auto"><br></div><div dir=3D"auto">Th=
ank you for your guidance.</div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Regards,</div><div dir=3D"auto">Srinath.</div></div><div class=3D"gmail_=
extra"><br><div class=3D"gmail_quote">On 19-Aug-2017 8:25 AM, &quot;Bjorn H=
elgaas&quot; &lt;<a href=3D"mailto:helgaas@kernel.org">helgaas@kernel.org</=
a>&gt; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed=
, Aug 16, 2017 at 10:33:12PM +0530, Srinath Mannam wrote:<br>
&gt; Hi Bjorn,<br>
&gt;<br>
&gt; Thank you for the feedback.<br>
&gt;<br>
&gt; My comments are in lined.<br>
&gt;<br>
&gt; On Wed, Aug 16, 2017 at 7:13 PM, Bjorn Helgaas &lt;<a href=3D"mailto:h=
elgaas@kernel.org">helgaas@kernel.org</a>&gt; wrote:<br>
&gt; &gt; On Fri, Aug 04, 2017 at 08:27:28PM +0530, Srinath Mannam wrote:<b=
r>
&gt; &gt;&gt; Concurrency issue is observed during pci enable bridge called=
<br>
&gt; &gt;&gt; for multiple pci devices initialization in SMP system.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Setup details:<br>
&gt; &gt;&gt;=C2=A0 - SMP system with 8 ARMv8 cores running Linux kernel(4.=
11).<br>
&gt; &gt;&gt;=C2=A0 - Two EPs are connected to PCIe RC through bridge as sh=
own<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 in the below figure.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 [RC]<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 [BRIDGE]<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ------=
-----<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [EP]=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 [EP]<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Issue description:<br>
&gt; &gt;&gt; After PCIe enumeration completed EP driver probe function cal=
led<br>
&gt; &gt;&gt; for both the devices from two CPUS simultaneously.<br>
&gt; &gt;&gt; From EP probe function, pci_enable_device_mem called for both=
 the EPs.<br>
&gt; &gt;&gt; This function called pci_enable_bridge enable for all the bri=
dges<br>
&gt; &gt;&gt; recursively in the path of EP to RC.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Inside pci_enable_bridge function, at two places concurrency =
issue is<br>
&gt; &gt;&gt; observed.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Place 1:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0CPU 0:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A01. Done Atomic increment dev-&gt;enable_cn=
t<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 in pci_enable_device_flags<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A02. Inside pci_enable_resources<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A03. Completed pci_read_config_word(dev, PCI=
_COMMAND, &amp;cmd)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A04. Ready to set PCI_COMMAND_MEMORY (0x2) i=
n<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_write_config_word(dev, PCI_COM=
MAND, cmd)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0CPU 1:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A01. Check pci_is_enabled in function pci_en=
able_bridge<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 and it is true<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A02. Check (!dev-&gt;is_busmaster) also true=
<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A03. Gone into pci_set_master<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A04. Completed pci_read_config_word(dev, PCI=
_COMMAND, &amp;old_cmd)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A05. Ready to set PCI_COMMAND_MASTER (0x4) i=
n<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_write_config_word(dev, PCI_COM=
MAND, cmd)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; By the time of last point for both the CPUs are read value 0 =
and<br>
&gt; &gt;&gt; ready to write 2 and 4.<br>
&gt; &gt;&gt; After last point final value in PCI_COMMAND register is 4 ins=
tead of 6.<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Place 2:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0CPU 0:<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A01. Done Atomic increment dev-&gt;enable_cn=
t in<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_enable_device_flags<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Signed-off-by: Srinath Mannam &lt;<a href=3D"mailto:srinath.m=
annam@broadcom.com">srinath.mannam@broadcom.com</a>&gt;<br>
&gt; &gt;&gt; ---<br>
&gt; &gt;&gt;=C2=A0 drivers/pci/pci.c | 8 ++++++--<br>
&gt; &gt;&gt;=C2=A0 1 file changed, 6 insertions(+), 2 deletions(-)<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c<br>
&gt; &gt;&gt; index af0cc34..12721df 100644<br>
&gt; &gt;&gt; --- a/drivers/pci/pci.c<br>
&gt; &gt;&gt; +++ b/drivers/pci/pci.c<br>
&gt; &gt;&gt; @@ -52,6 +52,7 @@ static void pci_pme_list_scan(struct work_s=
truct *work);<br>
&gt; &gt;&gt;=C2=A0 static LIST_HEAD(pci_pme_list);<br>
&gt; &gt;&gt;=C2=A0 static DEFINE_MUTEX(pci_pme_list_<wbr>mutex);<br>
&gt; &gt;&gt;=C2=A0 static DECLARE_DELAYED_WORK(pci_pme_<wbr>work, pci_pme_=
list_scan);<br>
&gt; &gt;&gt; +static DEFINE_MUTEX(pci_bridge_mutex)<wbr>;<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 struct pci_pme_device {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0struct list_head list;<br>
&gt; &gt;&gt; @@ -1348,10 +1349,11 @@ static void pci_enable_bridge(struct =
pci_dev *dev)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bridge)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_ena=
ble_bridge(bridge);<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;pci_bridge_mutex);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pci_is_enabled(dev)) {<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!de=
v-&gt;is_busmaster)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0pci_set_master(dev);<br>
&gt; &gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br=
>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0retval =3D pci_enable_device(dev);<=
br>
&gt; &gt;&gt; @@ -1359,6 +1361,8 @@ static void pci_enable_bridge(struct pc=
i_dev *dev)<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err=
(&amp;dev-&gt;dev, &quot;Error enabling bridge (%d), continuing\n&quot;,<br=
>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0retval);<br>
&gt; &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_master(dev);<br>
&gt; &gt;&gt; +end:<br>
&gt; &gt;&gt; +=C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;pci_bridge_<wbr>mutex)=
;<br>
&gt; &gt;<br>
&gt; &gt; I think this will deadlock because we&#39;re holding pci_bridge_m=
utex<br>
&gt; &gt; while we call pci_enable_device(), which may recursively call<br>
&gt; &gt; pci_enable_bridge(), which would try to acquire pci_bridge_mutex<=
br>
&gt; &gt; again.=C2=A0 My original suggestion of a mutex in the host bridge=
 would<br>
&gt; &gt; have the same problem.<br>
&gt;<br>
&gt; This extra check &quot;if (bridge &amp;&amp; !pci_is_enabled(bridge))&=
quot; will resolve<br>
&gt; the deadlock in the present patch.<br>
<br>
Oh, I see.=C2=A0 In pci_enable_bridge(X), the recursive call to enable<br>
upstream bridges happens *before* acquiring pci_bridge_mutex, so when<br>
we call pci_enable_device(X) while holding the mutex, any upstream<br>
bridges will have been already enabled.<br>
<br>
We recurse all the way to the top of the hierarchy, acquire the mutex,<br>
enable the bridge, release the mutex, then unwind and repeat for each<br>
bridge on the way down to the endpoint.<br>
<br>
&gt; &gt; We talked about using device_lock() earlier.=C2=A0 You found some=
 problems<br>
&gt; &gt; with that, and I&#39;d like to understand them better.=C2=A0 You =
said:<br>
&gt; &gt;<br>
&gt; &gt;&gt; But the pci_enable_bridge is called in the context of the dri=
ver<br>
&gt; &gt;&gt; probe function, we will have nexted lock problem.<br>
&gt; &gt;<br>
&gt; &gt; The driver core does hold device_lock() while calling the driver =
probe<br>
&gt; &gt; function, in this path:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0device_initial_probe<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0__device_attach<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0device_lock(dev)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # &lt;-- lock<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0__device_attach_driver<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_device_probe<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0...<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;probe=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# driver prob=
e function<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0device_unlock(dev)=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # &lt;-- unlock<br>
&gt; &gt;<br>
&gt; &gt; I didn&#39;t see your patch using device_lock(), but what I had i=
n mind<br>
&gt; &gt; was something like the patch below, where pci_enable_bridge() acq=
uires<br>
&gt; &gt; the device_lock() of the bridge.<br>
&gt; &gt;<br>
&gt; &gt; For the sake of argument, assume a hierarchy:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0bridge A -&gt; bridge B -&gt; endpoint C<br>
&gt; &gt;<br>
&gt; &gt; Here&#39;s what I think will happen:<br>
&gt; &gt;<br>
&gt; &gt;=C2=A0 =C2=A0device_lock(C)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# driver core<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0...<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;probe(C)=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# driver =
probe function<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_enable_device_flags(C)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_enable_bridge(B)=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# enable C&#39;s upstream bridge<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_lock(B)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_enable_bridge(=
A)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# enable B&#39;s upstream bridge<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_lock=
(A)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# A has no upstream brid=
ge<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_enable_=
device(A)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_p=
ci_enable_device(A)=C2=A0 # update A PCI_COMMAND<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_mas=
ter(A)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # update A PCI_COMMAND<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_unlo=
ck(A)<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_enable_device(=
B)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# update B PCI_COMMAND<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_master(B)=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # update B PCI_COMMAND<br>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0device_unlock(B)<b=
r>
&gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_pci_enable_device(C)=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 # update C PCI_COMMAND<br>
&gt; &gt;=C2=A0 =C2=A0device_unlock(C)<br>
&gt; &gt;<br>
&gt; &gt; I don&#39;t see a nested lock problem here.=C2=A0 What am I missi=
ng?<br>
&gt; From the probe call device_lock will taken to that endpoint and also<b=
r>
&gt; for the bus. In this order<br>
&gt;<br>
&gt; pci register driver(C)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 #(driver_register())<br>
&gt; device_lock(B);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0# lock for parent (__driver_attach())<br>
&gt; device_lock(C)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0# lock for endpoint (__driver_attach())<br>
&gt; driver probe(C)<br>
&gt; pci_enable_bridge()<br>
&gt; device_lock(B);=C2=A0 # here we see the deadlock.because of parent dev=
ice lock<br>
<br>
Oh, it&#39;s the &quot;needed for USB&quot; thing in __driver_attach();<br>
is that right?<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dev-&gt;parent)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
/* Needed for USB */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 device_lock(dev-&gt=
;parent);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 device_lock(dev);<br>
<br>
Looks like that came from bf74ad5bc417 (&quot;[PATCH] Hold the device&#39;s=
<br>
parent&#39;s lock during probe and remove&quot;), and it&#39;s probably not=
<br>
practical to change it, even if it&#39;s not strictly needed for PCI.<br>
<br>
So I think your patch is correct and I applied it to pci/enumeration<br>
for v4.14.=C2=A0 Thanks for your patience.<br>
<br>
I didn&#39;t quite understand the &quot;Place 2&quot; concurrency issue in =
your<br>
changelog.=C2=A0 I *think* I understand &quot;Place 1&quot;, and I updated =
the<br>
changelog with an ordering that I think illustrates the problem and<br>
added a comment to that effect in the code.<br>
<br>
<br>
commit 40f11adc7cd9281227f0a6a627d966<wbr>dd0a5f0cd9<br>
Author: Srinath Mannam &lt;<a href=3D"mailto:srinath.mannam@broadcom.com">s=
rinath.mannam@broadcom.com</a>&gt;<br>
Date:=C2=A0 =C2=A0Fri Aug 18 21:50:48 2017 -0500<br>
<br>
=C2=A0 =C2=A0 PCI: Avoid race while enabling upstream bridges<br>
<br>
=C2=A0 =C2=A0 When we enable a device, we first enable any upstream bridges=
.=C2=A0 If a bridge<br>
=C2=A0 =C2=A0 has multiple downstream devices and we enable them simultaneo=
usly, the race<br>
=C2=A0 =C2=A0 to enable the upstream bridge may cause problems.=C2=A0 Consi=
der this hierarchy:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 bridge A --+-- device B<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0+-- device C<=
br>
<br>
=C2=A0 =C2=A0 If drivers for B and C call pci_enable_device() simultaneousl=
y, both will<br>
=C2=A0 =C2=A0 attempt to enable A, which involves setting PCI_COMMAND_MASTE=
R via<br>
=C2=A0 =C2=A0 pci_set_master() and PCI_COMMAND_MEMORY via pci_enable_resour=
ces().<br>
<br>
=C2=A0 =C2=A0 In the following sequence, B&#39;s update to set A&#39;s PCI_=
COMMAND_MEMORY is<br>
=C2=A0 =C2=A0 lost, and neither B nor C will work correctly:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 C=
<br>
=C2=A0 =C2=A0 =C2=A0 pci_set_master(A)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D read(A, PCI_COMMAND)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd |=3D PCI_COMMAND_MASTER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_set_m=
aster(A)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cm=
d =3D read(A, PCI_COMMAND)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cm=
d |=3D PCI_COMMAND_MASTER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 write(A, PCI_COMMAND, cmd)<br>
=C2=A0 =C2=A0 =C2=A0 pci_enable_device(A)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_enable_resources(A)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D read(A, PCI_COMMAND)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd |=3D PCI_COMMAND_MEMORY<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 write(A, PCI_COMMAND, cmd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0wr=
ite(A, PCI_COMMAND, cmd)<br>
<br>
=C2=A0 =C2=A0 Avoid this race by holding a new pci_bridge_mutex while enabl=
ing a bridge.<br>
=C2=A0 =C2=A0 This ensures that both PCI_COMMAND_MASTER and PCI_COMMAND_MEM=
ORY will be<br>
=C2=A0 =C2=A0 updated before another thread can start enabling the bridge.<=
br>
<br>
=C2=A0 =C2=A0 Note that although pci_enable_bridge() is recursive, it enabl=
es any<br>
=C2=A0 =C2=A0 upstream bridges *before* acquiring the mutex.=C2=A0 When it =
acquires the mutex<br>
=C2=A0 =C2=A0 and calls pci_set_master() and pci_enable_device(), any upstr=
eam bridges<br>
=C2=A0 =C2=A0 have already been enabled so pci_enable_device() will not dea=
dlock by<br>
=C2=A0 =C2=A0 calling pci_enable_bridge() again.<br>
<br>
=C2=A0 =C2=A0 Signed-off-by: Srinath Mannam &lt;<a href=3D"mailto:srinath.m=
annam@broadcom.com">srinath.mannam@broadcom.com</a>&gt;<br>
=C2=A0 =C2=A0 [bhelgaas: changelog, comment]<br>
=C2=A0 =C2=A0 Signed-off-by: Bjorn Helgaas &lt;<a href=3D"mailto:bhelgaas@g=
oogle.com">bhelgaas@google.com</a>&gt;<br>
<br>
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c<br>
index af0cc3456dc1..7cb29a223b73 100644<br>
--- a/drivers/pci/pci.c<br>
+++ b/drivers/pci/pci.c<br>
@@ -52,6 +52,7 @@ static void pci_pme_list_scan(struct work_struct *work);<=
br>
=C2=A0static LIST_HEAD(pci_pme_list);<br>
=C2=A0static DEFINE_MUTEX(pci_pme_list_<wbr>mutex);<br>
=C2=A0static DECLARE_DELAYED_WORK(pci_pme_<wbr>work, pci_pme_list_scan);<br=
>
+static DEFINE_MUTEX(pci_bridge_mutex)<wbr>;<br>
<br>
=C2=A0struct pci_pme_device {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct list_head list;<br>
@@ -1348,10 +1349,16 @@ static void pci_enable_bridge(struct pci_dev *dev)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (bridge)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_enable_bridge(b=
ridge);<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Hold pci_bridge_mutex to prevent a race when=
 enabling two<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * devices below the bridge simultaneously.=C2=
=A0 The race may cause a<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * PCI_COMMAND_MEMORY update to be lost (see ch=
angelog).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(&amp;pci_bridge_mutex);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pci_is_enabled(dev)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!dev-&gt;is_bus=
master)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 pci_set_master(dev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 retval =3D pci_enable_device(dev);<br>
@@ -1359,6 +1366,8 @@ static void pci_enable_bridge(struct pci_dev *dev)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;dev-&g=
t;dev, &quot;Error enabling bridge (%d), continuing\n&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 retval);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_set_master(dev);<br>
+end:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unlock(&amp;pci_bridge_<wbr>mutex);<br>
=C2=A0}<br>
<br>
=C2=A0static int pci_enable_device_flags(struct pci_dev *dev, unsigned long=
 flags)<br>
@@ -1383,7 +1392,7 @@ static int pci_enable_device_flags(struct pci_dev *de=
v, unsigned long flags)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* already enabled */<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bridge =3D pci_upstream_bridge(dev);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bridge)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (bridge &amp;&amp; !pci_is_enabled(bridge))<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_enable_bridge(b=
ridge);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* only skip sriov related */<br>
</blockquote></div></div>

--001a113cfa3e684c1d055712cb66--
